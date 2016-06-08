# Changelog

## 0.2.0

- Integration of `grind` in app template

**Breaking changes:**
    - No reflectable on model, use of `dogma-codegen`
    - Pass a `ModelEncoder` or/and `ModelDecoder` to `HttpService` to convert the body;
    - A `PolyceModel` has now
        * `encode` method
        * factory constructor `decode`
    - Config file is now `polyce.settings.yaml`