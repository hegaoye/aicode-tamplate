buildscript {
    ext {
        springBootVersion = '2.1.5.RELEASE'
    }
    repositories {
        maven { url "https://repo.spring.io/milestone" }
        maven { url "http://maven.jahia.org/maven2" }
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
    maven { url "http://maven.jahia.org/maven2" }
    mavenCentral()
    jcenter()
}

ext {
    set('springCloudVersion', 'Greenwich.RELEASE')
}

dependencies {
    implementation('org.springframework.cloud:spring-cloud-starter-netflix-eureka-server')
    testImplementation('org.springframework.boot:spring-boot-starter-test')
}

dependencyManagement {
    imports {
        mavenBom "org.springframework.cloud:spring-cloud-dependencies:${r'${'}springCloudVersion}"
    }
}
