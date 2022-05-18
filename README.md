# miniaudio library

A [miniaudio](https://github.com/mackron/miniaudio) fork with custom build for library linking usage.

## Compile

Use either `build.sh` or `cmake` to compile the static library.

### CMake and Ninja

Example `cmake` with `ninja`:

```
cmake -S . -bbuild -DCMAKE_BUILD_TYPE=Release -GNinja
```

Build using ninja

```
ninja -C build
```

### CMake

Example using just `cmake`.

```
cmake -S . -bbuild -DCMAKE_BUILD_TYPE=Release
```

```
cmake --build build
```

