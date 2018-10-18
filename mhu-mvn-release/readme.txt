
Start:

docker run -it --name mhu-mvn-release -h mhus mhu-mvn-release

you can share a local maven repository, add
 -v /$PATH_M2:/root/.m2

 and you can share the sources, add
  -v /$PATH_DEPLOY:/deploy

docker run -it --name mhu-mvn-release -h mhus -v $PATH_DEPLOY:/deploy -v $PATH_M2:/root/.m2 -v $PATH_GNUPG_INSTALL:/root/.gnupg mhu-mvn-release

Import Keys:

gpg --import gpg_secret_keys.asc 
gpg --import gpg_public_keys.asc

Export Keys:

gpg --export-secret-keys > ~/Downloads/gpg_secret_keys.asc
gpg --export > ~/Downloads/gpg_public_keys.asc
