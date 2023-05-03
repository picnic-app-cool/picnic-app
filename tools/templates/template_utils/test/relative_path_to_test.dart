import 'package:template_utils/file_utils.dart';
import 'package:test/test.dart';

void main() {
  test("path in subfolder few levels above", () {
    final relative = "/Users/test/Developer/andrzejchm/flutter-clean-arch-templates"
        .relativePathTo("/Users/test/Developer/org-name/project-name");
    expect(relative, "../../org-name/project-name");
  });

  test("path within current directory", () {
    final relative = "/Users/test/Developer/andrzejchm/flutter-clean-arch-templates"
        .relativePathTo("/Users/test/Developer/andrzejchm/flutter-clean-arch-templates/subproject/path");
    expect(relative, "subproject/path");
  });

  test("path above current directory", () {
    final relative = "/Users/test/Developer/andrzejchm/flutter-clean-arch-templates/subproject/path"
        .relativePathTo("/Users/test/Developer/andrzejchm/flutter-clean-arch-templates");
    expect(relative, "../..");
  });
}
