//apply plugin: 'war'
apply plugin: 'org.springframework.boot'

jar {
    baseName = 'api-admin'
    manifest {
        attributes "Manifest-Version": 1.0,
                "Main-Class": '${basePackage}.AdminApplication'
    }
}
dependencies {
    compile('org.springframework.boot:spring-boot-starter-web')
    compile('com.alibaba:druid-spring-boot-starter:1.1.10')
    compile fileTree(dir: '../libs', include: ['*.jar'])
    compile project(':base-web')
    compile project(':${projectName}-sv')
    testCompile('org.springframework.boot:spring-boot-starter-test')

}


