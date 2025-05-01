# 🚀 WoPe (Write Once, Post Everywhere) para iOS

Una pequeña app en SwiftUI para publicar posts en una cuenta de **Bluesky** desde tu iPhone. Diseñada para uso personal sin necesidad de publicar en la App Store.

---

## ✨ Características

- Área de texto para escribir tu post
- Checkbox para elegir si quieres publicarlo en Bluesky
- Botón de envío
- Spinner mientras se publica
- Simulación del post publicado en la interfaz
- No se suben tus credenciales gracias a `Secrets.plist`

---

## 🔐 Configuración de Secrets

Crea un archivo `Secrets.plist` en la raíz de tu proyecto (Xcode > New File > Property List) con este contenido:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>username</key>
    <string>tuusuario.bsky.social</string>
    <key>password</key>
    <string>tusupercontraseña</string>
</dict>
</plist>
```

Agrega esto a tu `.gitignore`:

```
Secrets.plist
```

---

## 🛠️ Requisitos

- Xcode 15+
- Un iPhone con tu cuenta de desarrollo gratuita
- Cuenta de Bluesky

---

## 🚀 Ejecución

1. Clona este repo
2. Abre el proyecto en Xcode
3. Añade tu `Secrets.plist`
4. Conecta tu iPhone y pulsa play ▶️

---

## 🙌 Créditos y agradecimientos

Este proyecto fue desarrollado paso a paso con la ayuda de **ChatGPT** y muchas ganas 😄

---

## 🧠 Futuras ideas

- Modo oscuro
- Publicar imágenes
- Soporte para otras redes como Mastodon o Nostr

---

¡Disfruta y postea responsablemente! 💬✨


