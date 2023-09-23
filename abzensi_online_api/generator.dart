import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print("Usage: dart generator.dart <table_name>");
    return;
  }

  var tableName = args[0];
  var modelName = _capitalize(_singularize(tableName));
  var apiControllerName = '${modelName}ApiController';

  _generateModel(modelName, tableName);
  _generateApiController(apiControllerName, modelName, tableName);
  _generateApiRoutes(tableName, apiControllerName);

  print("API CRUD components for $tableName generated successfully!");
}

void _generateModel(String modelName, String tableName) {
  var modelContent = '''
<?php

namespace App\\Models;

use Illuminate\\Database\\Eloquent\\Model;

class $modelName extends Model
{
    protected \$table = '$tableName';
    protected \$fillable = ['column1', 'column2']; // Replace with appropriate column names
}
''';

  _createFile('app/Models/$modelName.php', modelContent);
}

void _generateApiController(
    String controllerName, String modelName, String tableName) {
  var apiControllerContent = '''
<?php

namespace App\\Http\\Controllers;

use Illuminate\\Http\\Request;
use App\\Models\\$modelName;

class $controllerName extends Controller
{
    public function index()
    {
        \$limit = request()->input('limit', 10);
        \$items = $modelName::paginate(\$limit);
        \$data = \$items->items();
        \$meta = [
            'currentPage' => \$items->currentPage(),
            'perPage' => \$items->perPage(),
            'total' => \$items->total(),
        ];
        if (\$items->hasMorePages()) {
            \$meta['next_page_url'] = url(\$items->nextPageUrl());
        }
        if (\$items->currentPage() > 2) {
            \$meta['prev_page_url'] = url(\$items->previousPageUrl());
        }
        if (\$items->lastPage() > 1) {
            \$meta['last_page_url'] = url(\$items->url(\$items->lastPage()));
        }
        return response()->json(['data' => \$data, 'meta' => \$meta]);
    }

    public function store(Request \$request)
    {
        \$item = $modelName::create(\$request->all());
        return response()->json(['data' => \$item], 201);
    }

    public function show(\$id)
    {
        \$item = $modelName::findOrFail(\$id);
        return response()->json(['data' => \$item]);
    }

    public function update(Request \$request, \$id)
    {
        \$item = $modelName::findOrFail(\$id);
        \$item->update(\$request->all());
        return response()->json(['data' => \$item]);
    }

    public function destroy(\$id)
    {
        \$item = $modelName::findOrFail(\$id);
        \$item->delete();
        return response(null, 204);
    }
}
''';

  _createFile('app/Http/Controllers/$controllerName.php', apiControllerContent);
}

void _generateApiRoutes(String tableName, String controllerName) {
  if (_doesApiRoutesExist(tableName)) return;
  var apiRoutesContent = '''
Route::prefix('$tableName')->middleware('auth:sanctum')->group(function () {
    Route::get('', [$controllerName::class, 'index']);
    Route::post('', [$controllerName::class, 'store']);
    Route::get('{id}', [$controllerName::class, 'show']);
    Route::put('{id}', [$controllerName::class, 'update']);
    Route::delete('{id}', [$controllerName::class, 'destroy']);
});
''';

  _appendToApiRoutes(apiRoutesContent, tableName, controllerName);
}

bool _doesApiRoutesExist(String tableName) {
  var path = 'routes/api.php';
  var file = File(path);

  if (!file.existsSync()) {
    return false;
  }

  var fileContent = file.readAsStringSync();
  return fileContent.contains("Route::prefix('$tableName')");
}

bool _doesApiControllersExist(String tableName, String controllerName) {
  var path = 'routes/api.php';
  var file = File(path);

  if (!file.existsSync()) {
    return false;
  }

  var fileContent = file.readAsStringSync();
  return fileContent.contains("use App\\Http\\Controllers\\$controllerName");
}

void _createFile(String path, String content) {
  var file = File(path);

  var mode = FileMode.write;
  file.writeAsStringSync(content, mode: mode);
}

String _capitalize(String text) {
  return text[0].toUpperCase() + text.substring(1);
}

String _singularize(String text) {
  if (text.endsWith('s')) {
    return text.substring(0, text.length - 1);
  }
  return text;
}

void _appendToApiRoutes(
    String content, String tableName, String controllerName) {
  var path = 'routes/api.php';
  var file = File(path);

  if (!file.existsSync()) {
    print(
        "File $path does not exist. Make sure the api.php file exists in the routes directory.");
    return;
  }

  var fileContent = file.readAsStringSync();
  var lines = fileContent.split('\n');

  // Add import statement at the top
  if (!_doesApiControllersExist(tableName, controllerName)) {
    lines.insert(1, "use App\\Http\\Controllers\\$controllerName;");
  }
  // Add the new content
  lines.add(content);
  _createFile(path, lines.join('\n'));
}
