package com.my;

import com.my.project.entity.Project;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.FileResourceLoader;
import org.beetl.core.resource.StringTemplateResourceLoader;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TestBeetl {

    public static void main(String[] args) throws IOException {
        a();
    }

    public static void a() throws IOException {
        String root = System.getProperty("user.dir") + File.separator + "\\mm\\src\\main\\resources";
        FileResourceLoader resourceLoader = new FileResourceLoader(root, "utf-8");
        Configuration cfg = Configuration.defaultConfiguration();
        GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);

        Project project = new Project();
        project.setCode("123");
        project.setAccount("abc");
        List<Project> list = new ArrayList<>();
        list.add(project);
        Template t = gt.getTemplate("pojo.beetl");
        t.binding("className", "Beetl");
        t.binding("projectList", list);
        String str = t.render();
        System.out.println(str);
    }

    public static void b() throws IOException {
        //初始化代码
        StringTemplateResourceLoader resourceLoader = new StringTemplateResourceLoader();
        Configuration cfg = Configuration.defaultConfiguration();
        GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);
        //获取模板
        Template t = gt.getTemplate("hello,${name}");
        t.binding("name", "beetl");
        //渲染结果
        String str = t.render();
        System.out.println(str);
    }
}
