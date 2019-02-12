[![](https://img.shields.io/badge/IBM%20Cloud-powered-blue.svg)](https://bluemix.net)
[![Platform](https://img.shields.io/badge/platform-swift-lightgrey.svg?style=flat)](https://developer.ibm.com/swift/)

# Use as capacidades cognitivas do seu App iOS com Core ML e Watson | With Watson

Este aplicativo iOS utiliza o serviço do Watson Visual Recognition para analisar imagens tiradas no iPhone ou fotos do album utilizando um modelo treinado, pelo usuário, na plataforma do Watson Studio (conhecido também como *Data Platform*). Dessa forma, é possível entender como integrar uma [API do Watson](https://cloud.ibm.com/catalog?category=ai) em um projeto em Swift com o uso da [SDK para Swift](https://github.com/watson-developer-cloud/swift-sdk).

Acesse o [Dropbox](https://ibm.biz/dataset) para ter acesso aos Datasets de imagens disponíveis, ou crie o seu próprio conjunto de imagens.

![](https://github.com/victorshinya/with-watson/blob/master/doc/source/images/architecture.jpg)

## Componentes e tecnologias usadas

* [Visual Recognition](https://cloud.ibm.com/catalog/services/visual-recognition): Analise imagens para cenas, objetos, faces e outros conteúdos
* [Watson Studio](https://cloud.ibm.com/catalog/services/watson-studio): Plataforma de dados com ambiente colaborativo e conjunto de ferramentas para Cientista de Dados, Desenvolvedores e SMEs.
* [Cloud Object Storage](https://cloud.ibm.com/catalog/services/cloud-object-storage): Serviço de armazenamento de objetos na nuvem.
* [Swift](https://developer.apple.com/swift/): Linguagem de programação open-source para dispositivos Apple

## Como instalar e configurar localmente

Para instalar o aplicativo é necessário que você tenha instalado a última versão do [Xcode](https://developer.apple.com/xcode/) e [Cocoapods](https://cocoapods.org) (gerenciador de dependência para projetos de Swift e Objective-C).

### 1. Baixe o aplicativo

```sh
git clone https://github.com/victorshinya/with-watson.git
cd with-watson/
```

### 2. Baixe todas as dependências do projeto

```sh
pod install
```

### 3. Abra o projeto "With Watson.xcworkspace"

```sh
open With\ Watson.xcworkspace
```

### 4. Abra o arquivo Constants.swift

Abra o arquivo e preencha com a credencial do Watson Visual Recognition e o(s) modelo(s) treinado(s) de Visual Recognition - feito dentro do Watson Studio.

### 5. Execute com o comando CMD + R (ou aperte o botão play)

Agora execute o projeto no simulador do Xcode ou no seu próprio iPhone/iPod/iPad. Lembre-se de que não é possível abrir a camera dentro do simulador.

## License

MIT License

Copyright (c) 2018 Victor Kazuyuki Shinya
