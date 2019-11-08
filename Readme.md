# Marsha plugins

This repo contains optional plugins for the [Marsha](https://github.com/openfun/marsha) application.

Plugins are pure JavaScript files injected in the [LTI template](https://github.com/openfun/marsha/blob/e5dec6b8ae662ab35950e5976296653cb29dbd7c/src/backend/marsha/core/templates/core/lti.html#L14-L16) and executed when the target `iframe` is loaded.

## Getting started

Javascript file are hosted on an AWS S3 bucket and distrbuted using AWS CloudFront. To bootstrap everything we use terraform.


🔧 **Before you go further**, you need to create `./src/aws/env.d/development` and replace the relevant values with your own.

    $ cp ./env.d/development.dist ./env.d/development

Create the shared state bucket where `Terraform` will keep all the information on your deployments so different developers/machines/CI processes can interact with them:

    $ make state-create

Initialize your `Terraform` config:

    $ make init

In order to have multiple environments (_e.g._ `development`, `staging`, `preproduction` and `production`) you must create a Terraform workspace and use it before deploying the project:

    $ ./bin/terraform workspace create development

Then you can create the architecture and deploy all plugins:

    $ make deploy

At then end of the deployment terraform will output the AWS CloudFront url you will use to distribute javascript files.

## Available plugins

### Adways

Adways is an interactive videos solution. The plugin lives in `src/static/js/adways.js`. To distribute it the URL will be: `https://yourCloudFrontDomain.com/static/js/adways.js`.

To use it with marsha, the adways publication id must be added in the LTI url using the `adways_id` query string, this will automatically activate the plugin. Example: `https://marsha.education/lti/videos/7693f1cb-572e-4439-8f5a-e9ca5c32f062?adways_id={YOUR_PUBLICATION_ID}`.
