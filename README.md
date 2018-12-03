[![](https://img.shields.io/badge/IBM%20Cloud-powered-blue.svg)](https://bluemix.net)
[![Platform](https://img.shields.io/badge/platform-swift-lightgrey.svg?style=flat)](https://developer.ibm.com/swift/)

# Use as capacidades cognitivas do seu App iOS com Core ML e Watson | With Watson

Este aplicativo iOS utiliza o serviço do Watson Visual Recognition para analisar imagens tiradas no iPhone ou fotos do album utilizando um modelo pré-treinado pela IBM. Dessa forma, é possível entender como integrar uma [API do Watson](https://cloud.ibm.com/catalog?category=ai) em um projeto em Swift com o uso da [SDK para Swift](https://github.com/watson-developer-cloud/swift-sdk).

![](https://github.com/victorshinya/with-watson/blob/master/doc/source/images/architecture.jpg)

## Componentes e tecnologias usadas

* [Watson Visual Recognition](https://cloud.ibm.com/catalog/services/visual-recognition): Analise imagens para cenas, objetos, faces e outros conteúdos
* [Swift](https://developer.apple.com/swift/): Linguagem de programação open-source para dispositivos Apple

## Como instalar e configurar localmente

Para instalar o aplicativo é necessário que você tenha instalado a última versão do [Xcode](https://developer.apple.com/xcode/) e [Cocoapods](https://cocoapods.org) (gerenciador de dependência para projetos de Swift e Objective-C).

### 1. Baixe o aplicativo

```sh
git clone https://github.com/victorshinya/with-watson
cd with-watson
```

### 2. Baixe todas as dependências do projeto

```sh
pod install
```

### 3. Abra o projeto "With Watson.xcworkspace"

```sh
open With\ Watson.xcworkspace
```

### 4. Execute com o comando CMD + R (ou execute apertando o botão play)

## License

MIT License

Copyright (c) 2018 Victor Kazuyuki Shinya
