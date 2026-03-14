allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val safeBuildRoot = File(
    System.getenv("LOCALAPPDATA") ?: "C:/Temp",
    "ThripsNetBuild",
)
rootProject.buildDir = safeBuildRoot

subprojects {
    project.buildDir = File(safeBuildRoot, project.name)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(safeBuildRoot)
}
