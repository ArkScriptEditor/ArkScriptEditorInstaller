import 'dart:io';

class Installer {
  static File createFile(String path) => File(path);
  static Directory createDirectory(String path) => Directory(path);

  static void downloadFromUrl(String url, String path) {
    Map<String, String> variables = Platform.environment;
    String folder = '';

    folder =
        Platform.isWindows ? variables['UserProfile']! : variables['HOME']!;
    folder += r"\ArkScript Editor";

    HttpClient httpClient = HttpClient();
    httpClient.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      var pipe = response.pipe(createFile(path).openWrite());

      if (url ==
          "https://github.com/ArkScriptEditor/ArkScriptEditor/releases/download/test/text_editor.msix") {
        pipe.whenComplete(() => {
              Process.run('start', ['arkscript_editor.msix'],
                  workingDirectory: folder, runInShell: true)
            });
      }
    });
  }

  static void setupFolder() async {
    Map<String, String> variables = Platform.environment;
    String folder = '';

    folder =
        Platform.isWindows ? variables['UserProfile']! : variables['HOME']!;
    folder += r"\ArkScript Editor";

    createDirectory(folder).create();
    createFile(folder + r"\Config.txt")
        .writeAsString("fontSize 24\nzoom 100\ntheme dark");

    createDirectory(folder + r"\Discord").create();

    if (Platform.isWindows) {
      downloadFromUrl(
          "https://github.com/ArkScriptEditor/ArkScriptEditor/releases/download/test/discord-rpc.dll",
          folder + r"\Discord\discord-rpc.dll");
      downloadFromUrl(
          "https://github.com/ArkScriptEditor/ArkScriptEditor/releases/download/test/discord-rpc.lib",
          folder + r"\Discord\discord-rpc.lib");
    } else if (Platform.isLinux) {
      downloadFromUrl(
          "https://github.com/ArkScriptEditor/ArkScriptEditor/releases/download/test/discord-rpc.dll",
          folder + r"\Discord\discord-rpc.so");
    } else if (Platform.isMacOS) {
      downloadFromUrl(
          "https://github.com/ArkScriptEditor/ArkScriptEditor/releases/download/test/discord-rpc.dll",
          folder + r"\Discord\discord-rpc.dylib");
    }

    downloadFromUrl(
        "https://github.com/ArkScriptEditor/ArkScriptEditor/releases/download/test/text_editor.msix",
        folder + r"\arkscript_editor.msix");
  }
}
