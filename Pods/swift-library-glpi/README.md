# GLPI API Library for Swift

![GLPI banner](https://user-images.githubusercontent.com/29282308/31666160-8ad74b1a-b34b-11e7-839b-043255af4f58.png)

[![License](https://img.shields.io/badge/license-Apache_v2.0-blue.svg)](https://github.com/glpi-project/swift-library-glpi/blob/develop/LICENSE.md)
[![Follow twitter](https://img.shields.io/twitter/follow/GLPI_PROJECT.svg?style=social&label=Twitter&style=flat-square)](https://twitter.com/GLPI_PROJECT)
[![Project Status: WIP](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/)
[![Telegram Group](https://img.shields.io/badge/Telegram-Group-blue.svg)](https://t.me/glpien)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Greenkeeper badge](https://badges.greenkeeper.io/glpi-project/swift-library-glpi.svg)](https://greenkeeper.io/)

GLPI (_Gestionnaire Libre de Parc Informatique_) is a free IT Asset Management, issue tracking system and service desk solution.

It helps companies to manage their information system, since it's able to build an inventory of all the organization's assets and to manage administrative and financial tasks.

## Table of Contents

* [Synopsis](#synopsis)
* [Build Status](#build-status)
* [Compatibility Matrix](#matrix)
* [Documentation](#documentation)
* [Code Example](#code-example)
* [Versioning](#versioning)
* [Contact](#contact)
* [Contribute](#contribute)
* [Copying](#copying)

## Synopsis

This library created in Swift features several functionalities common to all GLPI APIs, for example:

* HTTP transport to APIs.
* Error handling
* Authentication
* JSON parsing
* Custom Item Types
* Media download/upload
* Batching
* Zero dependencies

You will be able to call all the methods that belong to the [GLPI REST API](https://github.com/glpi-project/glpi/blob/master/apirest.md), for more information visit the [project's website](https://glpi-project.github.io/swift-library-glpi/).

## Build Status

|**Release channel**|Beta Channel|
|:---:|:---:|
|[![Circle CI build](https://circleci.com/gh/glpi-project/swift-library-glpi/tree/master.svg?style=svg)](https://circleci.com/gh/glpi-project/swift-library-glpi/tree/master)|[![Circle CI build](https://circleci.com/gh/glpi-project/swift-library-glpi/tree/develop.svg?style=svg)](https://circleci.com/gh/glpi-project/swift-library-glpi/tree/develop)|

## Matrix

|**GLPI Version**|9.1.1|9.1.2|9.1.3|9.1.5|9.1.6|9.2.0|
|:----|----|----|----|---|---|---|
|**GLPI API Client**|||||||

## Documentation

We maintain a detailed documentation of the project on the [website](https://glpi-project.github.io/swift-library-glpi/).

## Code Example

It's easy to implement in your code

```swift
import Glpi

/// Init Session
GlpiRequest.initSessionByUserToken(userToken: "token") { data, response, error in
    print(data)
}

//
var queryString = QueryString.GetAnItem()
queryString.expandDropdowns = true
queryString.getHateoas = true

GlpiRequest.getItem(itemType: .Computer, itemID: 3, queryString: queryString) { data, response, error in
    if error == nil {
        print(data)
    }
}

```

## Versioning

In order to provide transparency on our release cycle and to maintain backward compatibility, GLPI is maintained under [the Semantic Versioning guidelines](http://semver.org/). We are committed to following and complying with the rules, the best we can.

See [the tags section of our GitHub project](https://github.com/glpi-project/swift-library-glpi/tags) for changelogs for each release version of GLPI. Release announcement posts on [the official Teclib' blog](http://www.teclib-edition.com/en/communities/blog-posts/) contain summaries of the most noteworthy changes made in each release.

## Contact

For notices about major changes and general discussion of GLPI development, subscribe to the [/r/glpi](http://www.reddit.com/r/glpi) subreddit.
You can also chat with us via IRC in [#GLPI on freenode](http://webchat.freenode.net/?channels=GLPI) or [@glpien on Telegram](https://t.me/glpien).

## Contribute

Want to file a bug, contribute some code, or improve documentation? Excellent! Read up on our
guidelines for [contributing](./CONTRIBUTING.md) and then check out one of our issues in the [Issues Dashboard](https://github.com/glpi-project/swift-library-glpi/issues).

## Copying

* **Code**: you can redistribute it and/or modify
    it under the terms of the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).
* **Documentation**: released under Attribution 4.0 International ([CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)).
