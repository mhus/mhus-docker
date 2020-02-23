# Docker committed/java image

This is a base image for Java. Unlike the default java:latest image it uses Oracle JDK rather than OpenJDK.

## Size

We've put some effort into making the image smaller (453mb vs 817mb for _/java) by:

* Performing the apt-get clean and rm of caches
* Delete the downloaded Java installer
* Deleting source code packages bundled with the JDK
* Deleting the larger libraries which support only the gui tools (mission control and visualvm)

You can go further by deleting the JavaFX and other platform specific libraries, but we wanted to offer a generic image.

## Entrypoints

The entrypoint is setup to be 'java' and directory called /java is offered the working directory and a shared volume. So you can run commands such as:

    docker run -u $(id -u) -v $(pwd):/java committed/java -jar jar-in-current-directory-on-host.jar

This will run the Jar file from the current directory (on the host) as the host user.

If you wish to access the container without running Java, then you can override with --entrypoint:

    docker run --entrypoint /bin/bash committed/java

## Building on this image

When you build your Dockerfile from this image, you should add/download jar and then override the ENTRYPOINT (and CMD). 

In its most basic form, something along the lines of:

    FROM committed/java
    MAINTAINER Me <me@example.com>
    
    # Provide a Jar filename and version
    ENV JAR_FILENAME myfatjar-1.0.0.jar

    # Either, download the Jars (eg direct from github releases)
    RUN wget https://example.com/path/to/${JAR_FILENAME}

    # Or ADD form from local
    # ADD ${JAR_FILENAME} ${JAR_FILENAME}

    # Run, defaulting to help 
    ENTRYPOINT ["java", "-jar", "${JAR_FILENAME}"]
    CMD "--help"

Of course you'll likely also want to install other packages, add volumes, expose ports and set users.
