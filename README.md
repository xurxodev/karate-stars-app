<img width="851" alt="karate-stars-header" src="https://user-images.githubusercontent.com/5593590/161581626-655a768b-24b9-4348-96e5-34ddfa78a0c2.png">

<a href="https://github.com/xurxodev/karate-stars-app/actions"><img src="https://github.com/xurxodev/karate-stars-app/actions/workflows/ci.yml/badge.svg" alt="build"></a>


Official Karate Stars App written in Flutter for Android and iOS

<a href="https://play.google.com/store/apps/details?id=com.xurxodev.karatestars">
  <img height=60 src="https://user-images.githubusercontent.com/5593590/161578886-7aa98b3e-3fe3-4caa-b29a-46433c3993a1.png" alt="build">
</a>
<a href="https://apps.apple.com/us/app/karate-stars/id1611034977">
  <img height=60 src="https://user-images.githubusercontent.com/5593590/161578894-8deab40a-a061-470b-ba06-76b1c357bb33.png" alt="build">
</a>


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
