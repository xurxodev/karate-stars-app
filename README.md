<img width="851" alt="karate-stars-header" src="https://user-images.githubusercontent.com/5593590/69491420-46440400-0e95-11ea-8978-c6a582aa4267.png">

[![Codemagic build status](https://api.codemagic.io/apps/5de693b73b536a0012c148ee/5de693b73b536a0012c148ed/status_badge.svg)](https://codemagic.io/apps/5de693b73b536a0012c148ee/5de693b73b536a0012c148ed/latest_build)

Official Karate Stars App written in Flutter for Android and iOS
## Setup

To install all dependencies:

```
$ flutter pub get
```

The app use generated code based on annotations. To generate code .


```
$ flutter packages pub run build_runner build
```

## Analyze the code

The code is analyzed using rules in analysis_options.yaml

```
$ Flutter analyze
```

## Tests

To execute tests

```
$ Flutter test
```

## License
Karate Stars is [GNU GPLv3](https://github.com/xurxodev/karate-stars-app/blob/master/LICENSE) license.
