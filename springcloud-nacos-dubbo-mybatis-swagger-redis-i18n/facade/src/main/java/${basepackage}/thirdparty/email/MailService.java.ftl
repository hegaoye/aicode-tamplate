/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.email;

/**
 * @Author borong
 * @Date 2019/5/17 16:12
 * @Description: 发送普通文本邮件的大致流程如下：
 * 1、判断是否有附件，如果有附件，那么处理的方式是不一样的（文本和二进制的区别）
 * 2、如果是简单文本邮件，处理邮件发送的基本事物
 * 3、如果是带附件的邮件，需要对附件做处理，同时处理邮件的基本事物
 * 4、发送邮件
 * 这个文本邮件发送可以实现的功能如下：
 * 1、多收件人、多抄送人、多密送人、可带附件
 * 2、请注意附件缺失不会导致邮件发送失败！请注意附件处理流程细节，免得出bug
 */

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.util.Arrays;
import java.util.Objects;
import java.util.Set;

/**
 * 邮件服务，实现简单文本邮件，HTML文件和附件邮件，模板邮件的发送
 * 支持的环境：JDK 1.8,SpringBoot 1.5.10,需要 mail-start，需要 thymeleaf 模板支持
 */
@Slf4j
@Service
public class MailService {

    //默认编码
    public static final String DEFAULT_ENCODING = "UTF-8";

    //本身邮件的发送者，来自邮件配置
    @Value("${r'${spring.mail.username}'}")
    private String userName;

    //模板引擎解析对象，用于解析模板
    @Autowired
    private TemplateEngine templateEngine;

    //邮件发送的对象，用于邮件发送
    @Resource
    private JavaMailSender mailSender;

    /**
     * 发送一个简单的文本邮件，可以附带附件：文本邮件发送的基本方法
     * @param subject：邮件主题，即邮件的邮件名称
     * @param content：邮件内容
     * @param toWho：需要发送的人
     * @param ccPeoples：需要抄送的人
     * @param bccPeoples：需要密送的人
     * @param attachments：需要附带的附件，附件请保证一定要存在，否则将会被忽略掉
     */
    public void sendSimpleTextMailActual(String subject, String content, String[] toWho, String[] ccPeoples, String[] bccPeoples, String[] attachments) {

        //检验参数：邮件主题、收件人、邮件内容必须不为空才能够保证基本的逻辑执行
        if (subject == null || toWho == null || toWho.length == 0 || content == null) {

            log.error("邮件-> {} 无法继续执行，因为缺少基本的参数：邮件主题、收件人、邮件内容", subject);

            throw new RuntimeException("模板邮件无法继续发送，因为缺少必要的参数！");
        }

        log.info("开始发送简单文本邮件：主题->{}，收件人->{}，抄送人->{}，密送人->{}，附件->{}", subject, toWho, ccPeoples, bccPeoples, attachments);

        //附件处理，需要处理附件时，需要使用二进制信息，使用 MimeMessage 类来进行处理
        if (attachments != null && attachments.length > 0) {

            try {
                //附件处理需要进行二进制传输
                MimeMessage mimeMessage = mailSender.createMimeMessage();

                MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, DEFAULT_ENCODING);

                //设置邮件的基本信息：这些函数都会在后面列出来
                boolean continueProcess = handleBasicInfo(helper, subject, content, toWho, ccPeoples, bccPeoples, false);

                //如果处理基本信息出现错误
                if (!continueProcess) {

                    log.error("邮件基本信息出错: 主题->{}", subject);

                    return;
                }

                //处理附件
                handleAttachment(helper, subject, attachments);

                //发送该邮件
                mailSender.send(mimeMessage);

                log.info("发送邮件成功: 主题->{}", subject);

            } catch (MessagingException e) {
                e.printStackTrace();

                log.error("发送邮件失败: 主题->{}", subject);
            }
        } else {

            //创建一个简单邮件信息对象
            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();

            //设置邮件的基本信息
            handleBasicInfo(simpleMailMessage, subject, content, toWho, ccPeoples, bccPeoples);

            //发送邮件
            mailSender.send(simpleMailMessage);

            log.info("发送邮件成功: 主题->{}", subject, toWho, ccPeoples, bccPeoples, attachments);
        }
    }

    /**
     * 处理二进制邮件的基本信息，比如需要带附件的文本邮件、HTML文件、图片邮件、模板邮件等等
     *
     * @param mimeMessageHelper：二进制文件的包装类
     * @param subject：邮件主题
     * @param content：邮件内容
     * @param toWho：收件人
     * @param ccPeoples：抄送人
     * @param bccPeoples：暗送人
     * @param isHtml：是否是HTML文件，用于区分带附件的简单文本邮件和真正的HTML文件
     *
     * @return ：返回这个过程中是否出现异常，当出现异常时会取消邮件的发送
     */
    private boolean handleBasicInfo(MimeMessageHelper mimeMessageHelper, String subject, String content, String[] toWho, String[] ccPeoples, String[] bccPeoples, boolean isHtml) {

        try {
            //设置必要的邮件元素

            //设置发件人
            mimeMessageHelper.setFrom(userName);
            //设置邮件的主题
            mimeMessageHelper.setSubject(subject);
            //设置邮件的内容，区别是否是HTML邮件
            mimeMessageHelper.setText(content, isHtml);
            //设置邮件的收件人
            mimeMessageHelper.setTo(toWho);

            //设置非必要的邮件元素，在使用helper进行封装时，这些数据都不能够为空

            if (ccPeoples != null) {
                //设置邮件的抄送人：MimeMessageHelper # Assert.notNull(cc, "Cc address array must not be null");
                mimeMessageHelper.setCc(ccPeoples);
            }

            if (bccPeoples != null) {
                //设置邮件的密送人：MimeMessageHelper # Assert.notNull(bcc, "Bcc address array must not be null");
                mimeMessageHelper.setBcc(bccPeoples);
            }

            return true;
        } catch (MessagingException e) {
            log.error("邮件基本信息出错->{}", subject);
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 用于填充简单文本邮件的基本信息
     *
     * @param simpleMailMessage：文本邮件信息对象
     * @param subject：邮件主题
     * @param content：邮件内容
     * @param toWho：收件人
     * @param ccPeoples：抄送人
     * @param bccPeoples：暗送人
     */
    private void handleBasicInfo(SimpleMailMessage simpleMailMessage, String subject, String content, String[] toWho, String[] ccPeoples, String[] bccPeoples) {

        //设置发件人
        simpleMailMessage.setFrom(userName);
        //设置邮件的主题
        simpleMailMessage.setSubject(subject);
        //设置邮件的内容
        simpleMailMessage.setText(content);
        //设置邮件的收件人
        simpleMailMessage.setTo(toWho);
        //设置邮件的抄送人
        simpleMailMessage.setCc(ccPeoples);
        //设置邮件的密送人
        simpleMailMessage.setBcc(bccPeoples);
    }

    /**
     * 用于处理附件信息，附件需要 MimeMessage 对象
     *
     * @param mimeMessageHelper：处理附件的信息对象
     * @param subject：邮件的主题，用于日志记录
     * @param attachmentFilePaths：附件文件的路径，该路径要求可以定位到本机的一个资源
     */
    private void handleAttachment(MimeMessageHelper mimeMessageHelper, String subject, String[] attachmentFilePaths) {

        //判断是否需要处理邮件的附件
        if (attachmentFilePaths != null && attachmentFilePaths.length > 0) {

            FileSystemResource resource;

            String fileName;

            //循环处理邮件的附件
            for (String attachmentFilePath : attachmentFilePaths) {

                //获取该路径所对应的文件资源对象
                resource = new FileSystemResource(new File(attachmentFilePath));

                //判断该资源是否存在，当不存在时仅仅会打印一条警告日志，不会中断处理程序。
                // 也就是说在附件出现异常的情况下，邮件是可以正常发送的，所以请确定你发送的邮件附件在本机存在
                if (!resource.exists()) {

                    log.warn("邮件->{} 的附件->{} 不存在！", subject, attachmentFilePath);

                    //开启下一个资源的处理
                    continue;
                }

                //获取资源的名称
                fileName = resource.getFilename();

                try {

                    //添加附件
                    mimeMessageHelper.addAttachment(fileName, resource);

                } catch (MessagingException e) {

                    e.printStackTrace();

                    log.error("邮件->{} 添加附件->{} 出现异常->{}", subject, attachmentFilePath, e.getMessage());
                }
            }
        }
    }

    /**
     * 可以用来发送带有图片的HTML模板邮件
     *
     * @param subject：邮件主题
     * @param toWho：收件人
     * @param ccPeoples：抄送人
     * @param bccPeoples：暗送人
     * @param attachments：附件
     * @param templateName：模板名称
     * @param context：模板解析需要的数据
     * @param imageResourceSet：图片资源的资源对象
     */
    public void sendHtmlTemplateMailActual(String subject, String[] toWho, String[] ccPeoples, String[] bccPeoples, String[] attachments, String templateName, Context context, Set<ImageResource> imageResourceSet) {

        //检验参数：邮件主题、收件人、模板名称必须不为空才能够保证基本的逻辑执行
        if (subject == null || toWho == null || toWho.length == 0 || templateName == null) {

            log.error("邮件-> {} 无法继续执行，因为缺少基本的参数：邮件主题、收件人、模板名称", subject);

            throw new RuntimeException("模板邮件无法继续发送，因为缺少必要的参数！");
        }

        //日志这个邮件的基本信息
        log.info("发送HTML模板邮件：主题->{}，收件人->{}，抄送人->{}，密送人->{}，附件->{}，模板名称->{}，模板解析参数->{}，图片资源->{}）", subject, toWho, ccPeoples, bccPeoples, attachments, templateName, context, imageResourceSet);

        try {

            //context不能够为空，需要进行检查
            if (context == null) {

                context = new Context();
                log.info("邮件->{} 的context为空！", subject);
            }

            //模板引擎处理模板获取到HTML字符串，这里会可能会抛出一个继承于RuntimeException的模板引擎异常
            String content = templateEngine.process(templateName, context);

            MimeMessage mimeMessage = mailSender.createMimeMessage();

            //默认编码为UTF-8
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, DEFAULT_ENCODING);

            //处理内联的图片资源的占位转换
            content = handleInLineImageResourceContent(helper, subject, content, imageResourceSet);

            log.info("解析邮件结果->{}", content);

            //处理基本信息
            boolean continueProcess = handleBasicInfo(helper, subject, content, toWho, ccPeoples, bccPeoples, true);

            if (!continueProcess) {

                log.error("邮件基本信息出错：主题->{}", subject);

                return;
            }

            //内联资源的资源附加，这个必须要放置在设置基本信息的操作后面，或者是全部内容解析完毕后才可以，不能边解析，边占位
            handleInLineImageResource(helper, subject, imageResourceSet);

            //处理附件
            handleAttachment(helper, subject, attachments);

            //发送该邮件
            mailSender.send(mimeMessage);

            log.info("发送邮件成功：主题->{}", subject);

        } catch (MessagingException e) {

            e.printStackTrace();

            log.error("发送邮件失败：邮件主题->{}", subject);
        }
    }

    /**
     * 处理内嵌图片的模板HTML邮件，返回一个已经修改过后的HTML字符串
     *
     * @param mimeMessageHelper：邮件信息包装类
     * @param subject：邮件主题
     * @param originContent：模板引擎所解析出来的原始HTML邮件
     * @param imageResourceSet：图片资源集合，用于字符集站位填充
     *
     * @return ：返回处理后的邮件内容
     */
    private String handleInLineImageResourceContent(MimeMessageHelper mimeMessageHelper, String subject, String originContent, Set<ImageResource> imageResourceSet) {

        //处理内嵌的HTML图片文件
        if (imageResourceSet != null && imageResourceSet.size() > 0) {

            //资源的占位符ID
            String rscId;
            //资源的路径
            String resourcePath = null;
            //图片的位置信息
            String placeHolder;
            //图片资源文件
            FileSystemResource resource;

            for (ImageResource imageResource : imageResourceSet) {

                //获取图片资源的基本信息
                rscId = imageResource.getId();
                placeHolder = imageResource.getPlaceholder();
                resourcePath = imageResource.getImageFilePath();

                resource = new FileSystemResource(new File(resourcePath));

                //判断图片资源是否存在
                if (!resource.exists()) {

                    log.warn("邮件->{} 内联图片->{} 找不到", subject, resourcePath);

                    continue;
                }

                //替换图片资源在HTML中的位置
                originContent = originContent.replace("\"" + ImageResource.PLACEHOLDERPREFIX + placeHolder + "\"", "\'cid:" + rscId + "\'");
            }
        }
        return originContent;
    }

    /**
     * 填充文本数据，因为数据填充必须在设置基本数据后面进行，所以讲内容和数据的填充进行分离
     *
     * @param mimeMessageHelper
     * @param subject：邮件主题，用于日志记录
     * @param imageResourceSet：资源
     */
    private void handleInLineImageResource(MimeMessageHelper mimeMessageHelper, String subject, Set<ImageResource> imageResourceSet) {

        if (imageResourceSet != null && imageResourceSet.size() > 0) {

            FileSystemResource resource;

            for (ImageResource imageResource : imageResourceSet) {

                resource = new FileSystemResource(new File(imageResource.getImageFilePath()));

                if (!resource.exists()) {

                    log.warn("邮件->{} 的内联图片文件->{} 不存在！", subject, imageResource);

                    continue;
                }

                try {

                    //添加内联资源
                    mimeMessageHelper.addInline(imageResource.getId(), resource);

                } catch (MessagingException e) {
                    e.printStackTrace();

                    log.error("邮件->{} 的内联图片文件->{} 添加错误！", subject, imageResource);
                }
            }
        }
    }

    /**
     * 传入的参数不能够为null
     *
     * @param args
     *
     * @return
     */
    private boolean assertNotNull(Object... args) {

        return Arrays.stream(args).noneMatch(Objects::isNull);
    }

    /**
     * 用于支撑HTML内嵌图片的支持类，拥有可以传输内联图片的全部基本信息
     */
    public final static class ImageResource {

        //占位符的前缀符号，用于替换字符串定位，比如：image1 在模板文件里面需要写成 #image1
        public static final String PLACEHOLDERPREFIX = "#";

        //用于文件区分，实现图片文件内联邮件发送
        private final String id;

        //这个图片需要填充到那个地方去，这个地方是一个标识，为了和其他标签区别开来，使用前缀加上标识符来进行区分，比如 ：#imageOrigin
        private final String placeholder;

        //图片的文件路径，该文件路径必须是本机文件系统的绝对路径，即可以直接 new File 的文件系统路径
        private final String imageFilePath;

        public ImageResource(String placeholder, String imageFilePath) {
            this.placeholder = placeholder;
            this.imageFilePath = imageFilePath;
            //自动生成id，用于区分图片文件
            this.id = String.valueOf(System.nanoTime());
        }

        public String getId() {
            return id;
        }

        public String getPlaceholder() {
            return placeholder;
        }

        public String getImageFilePath() {
            return imageFilePath;
        }

        @Override
        public String toString() {
            return "ImageResource{" + "id=" + id + ", placeholder='" + placeholder + '\'' + ", imageFilePath='" + imageFilePath + '\'' + '}';
        }
    }

}