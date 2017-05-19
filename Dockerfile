FROM node:6-alpine

MAINTAINER tobilg@gmail.com

# Set application name
ENV APP_NAME flink-framework

# Set application directory
ENV APP_DIR /usr/local/${APP_NAME}

# Set node env to production, so that npm install doesn't install the devDependencies
ENV NODE_ENV production

# Add application
ADD . ${APP_DIR}

# Change the workdir to the app's directory
WORKDIR ${APP_DIR}

# Setup of the application
RUN apk -U add --no-cache git && \
    rm -rf ${APP_DIR}/public/bower_components && \
    npm set progress=false && \
    npm install --silent && \
    npm install bower -g && \
    bower install --allow-root && \
    mkdir -p logs

CMD ["npm", "start"]
