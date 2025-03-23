'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "fc8c7912df8b5cc7db39ec511d3aa55e",
"version.json": "db03d218ae8783bf62acd48cbc124ad1",
"index.html": "f9407a3d0ad1145b4bfe1d835555601e",
"/": "f9407a3d0ad1145b4bfe1d835555601e",
"main.dart.js": "dec3060566ebdc690e45f18b09a71168",
"404.html": "0a27a4163254fc8fce870c8cc3a3f94f",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "4e42c292322c7f33d78aacf366673f2f",
"icons/Icon-192.png": "4e42c292322c7f33d78aacf366673f2f",
"icons/Icon-maskable-192.png": "4e42c292322c7f33d78aacf366673f2f",
"icons/Icon-maskable-512.png": "4e42c292322c7f33d78aacf366673f2f",
"icons/Icon-512.png": "4e42c292322c7f33d78aacf366673f2f",
"manifest.json": "59f81f24e82ec41beba91d0d3008b2ae",
"assets/AssetManifest.json": "02d42d0528ec54294cd2491e96f13581",
"assets/NOTICES": "a75a39c6e163ceda5d1fe45b3b395b06",
"assets/FontManifest.json": "c3aacac262d3e6cdae1c558f4129d5ae",
"assets/AssetManifest.bin.json": "052e2b4bb2c1b8a2b15dc16700f5508e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/youtube_player_iframe/assets/player.html": "663ba81294a9f52b1afe96815bb6ecf9",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "aac99bc88af60f1961d9e07b330be019",
"assets/fonts/MaterialIcons-Regular.otf": "be23271c68bdc6edb23307143a0aa590",
"assets/assets/images/logo.png": "0979c281bc303469426489b3745d7bd1",
"assets/assets/images/app_logo.png": "4e42c292322c7f33d78aacf366673f2f",
"assets/assets/icons/add_device.svg": "75f8a1dfc33d2d0a4c53f2b0cf4b98e8",
"assets/assets/icons/calender.svg": "e1857a6f5dddd379e6ec82edd7c141fe",
"assets/assets/icons/download.svg": "9d30ab6fdd35e39bfcc64c15828623f1",
"assets/assets/icons/dashboard_selected.svg": "9841b59ad1482756f7c851c2c7bfe31c",
"assets/assets/icons/gender.svg": "2c1b6d1b354c5e20542a06e7ed740ddd",
"assets/assets/icons/chat.svg": "ab5f2eae1e7ce9f5d7423431ff623b4e",
"assets/assets/icons/about.svg": "efd483fdd813e196ba0358e9dbd7fc90",
"assets/assets/icons/FAQ.svg": "2b074313a8570695b7a28e72b10b3a8f",
"assets/assets/icons/delete.svg": "c61531d38485ed243258f51d00ac73f2",
"assets/assets/icons/add-user.svg": "6aa2caed99d448d77f10f5dd2d93950e",
"assets/assets/icons/done.svg": "31b443bb90264a05cf9bbc65bbd1ee9c",
"assets/assets/icons/profile_selected.svg": "0dfba873ddea3272f4dfc93d229214ce",
"assets/assets/icons/swap.svg": "d1e781bdcf0f8d8224d2aaef7dd095d2",
"assets/assets/icons/privacy.svg": "929dd5ce9ad611c58f76f60d6fa157ea",
"assets/assets/setting/initial_settings.json": "1dbe3a292485e58773580def69714200",
"assets/assets/fonts/Outfit-Regular.ttf": "3a8c9c63d786bfd6b151d48916eb3df5",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
