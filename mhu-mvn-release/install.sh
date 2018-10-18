#!/bin/bash

. /root/.m2/mhus_env.sh
cd /deploy

while [ "x$START_WAIT" == "x1" ]; do
  echo "START_WAIT is set ... waiting"
  sleep 10
  . /root/.m2/mhus_env.sh
done

# mhus-lib
#
if [  "x$MHUS" != "xno" ]; then
	if [ ! -d mhus-lib ]; then
	  git clone https://github.com/mhus/mhus-lib.git
	  cd mhus-lib
	  mvn install || exit 1
	else
	  cd mhus-lib
	  git remote update
	  UPSTREAM=${1:-'@{u}'}
	  LOCAL=$(git rev-parse @)
      REMOTE=$(git rev-parse "$UPSTREAM")
	  BASE=$(git merge-base @ "$UPSTREAM")
      if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
        echo "Up-to-date"
      elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
	    git pull
		if [ "x$CLEAN" = "x1" ]; then
		  mvn clean
		fi
		mvn install || exit 1
	  fi
	fi
	
	cd ..
	
	# mhus-osgi-tools
	
	if [ ! -d mhus-osgi-tools ]; then
	  git clone https://github.com/mhus/mhus-osgi-tools.git
	  cd mhus-osgi-tools
	  mvn install || exit 1
	else
	  cd mhus-osgi-tools
	  git remote update
	  UPSTREAM=${1:-'@{u}'}
	  LOCAL=$(git rev-parse @)
      REMOTE=$(git rev-parse "$UPSTREAM")
	  BASE=$(git merge-base @ "$UPSTREAM")
      if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
        echo "Up-to-date"
      elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
	    git pull
		if [ "x$CLEAN" = "x1" ]; then
		  mvn clean
		fi
		mvn install || exit 1
	  fi
	fi
	
	cd ..

	# mhus-osgi-crypt
	
	if [ ! -d mhus-osgi-crypt ]; then
	  git clone https://github.com/mhus/mhus-osgi-crypt.git
	  cd mhus-osgi-crypt
	  mvn install || exit 1
	else
	  cd mhus-osgi-crypt
	  git remote update
	  UPSTREAM=${1:-'@{u}'}
	  LOCAL=$(git rev-parse @)
      REMOTE=$(git rev-parse "$UPSTREAM")
	  BASE=$(git merge-base @ "$UPSTREAM")
      if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
        echo "Up-to-date"
      elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
	    git pull
		if [ "x$CLEAN" = "x1" ]; then
		  mvn clean
		fi
		mvn install || exit 1
	  fi
	fi
	
	cd ..
	
	# mhus-transform
	
	if [ ! -d mhus-transform ]; then
	  git clone https://github.com/mhus/mhus-transform.git
	  cd mhus-transform
	  mvn install || exit 1
	else
	  cd mhus-transform
	  git remote update
	  UPSTREAM=${1:-'@{u}'}
	  LOCAL=$(git rev-parse @)
      REMOTE=$(git rev-parse "$UPSTREAM")
	  BASE=$(git merge-base @ "$UPSTREAM")
      if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
        echo "Up-to-date"
      elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
	    git pull
		if [ "x$CLEAN" = "x1" ]; then
		  mvn clean
		fi
		mvn install || exit 1
	  fi
	fi
	
	cd ..
	
	# mhus-sop
	
	if [ ! -d mhus-sop ]; then
	  git clone https://github.com/mhus/mhus-sop.git
	  cd mhus-sop
	  mvn install || exit 1
	else
	  cd mhus-sop
	  git remote update
	  UPSTREAM=${1:-'@{u}'}
	  LOCAL=$(git rev-parse @)
      REMOTE=$(git rev-parse "$UPSTREAM")
	  BASE=$(git merge-base @ "$UPSTREAM")
      if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
        echo "Up-to-date"
      elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
	    git pull
		if [ "x$CLEAN" = "x1" ]; then
		  mvn clean
		fi
		mvn install || exit 1
	  fi
	fi
	
	cd ..
	
	# mhus-ports
	
	if [ ! -d mhus-ports ]; then
	  git clone https://github.com/mhus/mhus-ports.git
	  cd mhus-ports
	  mvn install || exit 1
	else
	  cd mhus-ports
	  git remote update
	  UPSTREAM=${1:-'@{u}'}
	  LOCAL=$(git rev-parse @)
      REMOTE=$(git rev-parse "$UPSTREAM")
	  BASE=$(git merge-base @ "$UPSTREAM")
      if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
        echo "Up-to-date"
      elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
	    git pull
		if [ "x$CLEAN" = "x1" ]; then
		  mvn clean
		fi
		mvn install || exit 1
	  fi
	fi
	
	cd ..	
fi

# cherry-reactive

if [ ! -d cherry-reactive ]; then
  git clone https://github.com/mhus/cherry-reactive.git
  cd cherry-reactive
  mvn install || exit 1
else
  cd cherry-reactive
  git remote update
  UPSTREAM=${1:-'@{u}'}
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base @ "$UPSTREAM")
  if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
    echo "Up-to-date"
  elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
    git pull
	if [ "x$CLEAN" = "x1" ]; then
	  mvn clean
	fi
	mvn install || exit 1
  fi
fi

cd ..

# cherry-vault

if [ ! -d cherry-web ]; then
  git clone https://github.com/mhus/cherry-web.git
  cd cherry-web
  mvn install || exit 1
else
  cd cherry-web
  git remote update
  UPSTREAM=${1:-'@{u}'}
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base @ "$UPSTREAM")
  if [ $LOCAL = $REMOTE -a ! "x$CLEAN" = "x1" ]; then
    echo "Up-to-date"
  elif [ $LOCAL = $BASE -o "x$CLEAN" = "x1" ]; then
    git pull
	if [ "x$CLEAN" = "x1" ]; then
	  mvn clean
	fi
	mvn install || exit 1
  fi
fi

cd ../..

