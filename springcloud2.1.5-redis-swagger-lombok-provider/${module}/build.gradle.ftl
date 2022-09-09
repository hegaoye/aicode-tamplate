buildscript {
    ext {
        springBootVersion = '2.1.5.RELEASE'
    }
    repositories {
        maven { url "https://repo.spring.io/milestone" }
        maven { url "https://maven.jahia.org/maven2" }
        mavenCentral()
        jcenter()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${r'${'}springBootVersion}")
    }
}

apply plugin: 'java'
apply plugin: 'idea'
apply plugin: 'org.springframework.boot'
apply plugin: 'io.spring.dependency-management'

sourceCompatibility = 1.8
[compileJava, compileTestJava, javadoc]*.options*.encoding = "UTF-8"

repositories {
    maven { url "https://repo.spring.io/milestone" }
    maven { url "https://maven.jahia.org/maven2" }
    mavenCentral()
    jcenter()
}

ext {
    set('springCloudVersion', 'Greenwich.RELEASE')
}
dependencies {
    //Eureka Client
    implementation("org.springframework.cloud:spring-cloud-starter-netflix-eureka-client")
    // 通用依赖
    compile(
            "org.springframework.boot:spring-boot-starter-web",
            "org.springframework.cloud:spring-cloud-starter-feign:1.4.7.RELEASE",
            "com.alibaba:druid-spring-boot-starter:1.1.10"
    )

    //----------- commons  start--------------
//    compile('commons-beanutils:commons-beanutils:1.9.2')
//    compile('commons-codec:commons-codec:1.6')
//    compile('commons-collections:commons-collections:3.2.1')
//    compile('commons-dbcp:commons-dbcp:1.2.2')
//    compile('commons-discovery:commons-discovery:0.2')
//    compile('commons-fileupload:commons-fileupload:1.2.1')
//    compile('commons-httpclient:commons-httpclient:3.0.1')
//    compile('commons-io:commons-io:2.4')
//    compile('commons-lang:commons-lang:2.5')
//    compile('org.apache.commons:commons-lang3:3.4')
//    compile('commons-logging:commons-logging:1.2')
//    compile('commons-logging:commons-logging-api:1.1')
//    compile('commons-pool:commons-pool:1.6')
//    compile('org.apache.commons:commons-pool2:2.4.2')
//    compile('commons-net:commons-net:3.6')
    //-----------commons   end--------------

    //----------- mybatis mysql druid start--------------
    compile('org.mybatis.spring.boot:mybatis-spring-boot-starter:2.0.1')
    compile('com.github.miemiedev:mybatis-paginator:1.2.17')
    compile('mysql:mysql-connector-java:8.0.15')
    compile('com.alibaba:druid:1.1.19')
    //-----------mybatis mysql druid end--------------

    //-----------redis start--------------
    compile "org.springframework.boot:spring-boot-starter-data-redis:2.1.5.RELEASE"
    compile "redis.clients:jedis:3.0.1"
    //-----------redis end--------------

    // -----------okhttp start--------------
    compile "com.squareup.okhttp3:okhttp:4.0.0"
    compile "com.squareup.okhttp3:logging-interceptor:4.0.0"
    //-----------okhttp end--------------

    // -----------Sentry begin-----------
//    compile "io.sentry:sentry-logback:1.7.14"
    compile "io.sentry:sentry-log4j:1.7.14"
    //-----------Sentry end-----------

    //-----------swagger2 start--------------
    compile "io.springfox:springfox-swagger2:2.9.2"
    compile "io.springfox:springfox-swagger-ui:2.9.2"
    //-----------swagger2 end--------------

    compileOnly('org.projectlombok:lombok:1.18.8')
    compile('com.alibaba:fastjson:1.2.59')

    compile project(":core")
    compile project(':base-facade')
    compile project(':facade')
    compile project(':base-sv')
    compile fileTree(dir: 'libs', include: ['uid-generator-1.0.0-SNAPSHOT.jar'])
    testImplementation('org.springframework.boot:spring-boot-starter-test')
}

dependencyManagement {
    imports {
        mavenBom "org.springframework.cloud:spring-cloud-dependencies:${r'${'}springCloudVersion}"
    }
}