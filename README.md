# @cbechstein-digital/capacitor-media

A capacitor plugin for interacting with the media library

## Install

```bash
npm install @cbechstein-digital/capacitor-media
npx cap sync
```

## Setup

#### Angular:
To get a dummy response on the web, add the following to your `angular.json` under `projects.<PROJECT_NAME>.architect.build.options.assets`:
```angular2html
{
    "glob": "**/*.png",
    "input": "node_modules/@cbechstein-digital/capacitor-media/src/assets/web/",
    "output": "./assets/plugins/capacitor-media/web"
}
```

## Permissions
The required permissions for the plugin are as follows:

On `Android`, add the following two permissions to your `androidManifest.xml` inside the `manifest` tag:
```
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
      android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
```

On `iOS`, add the following key to your `Info.plist` file with a description about why does your app needs this permission:
```
<dict>
    .
    .
    .
    <key>NSPhotoLibraryUsageDescription</key>
    <string>To show the thumbnail of the latest recorded video in the app</string>
    .
    .
    .
</dict>
```
Replace the description between `string` based on your need.

## API

<docgen-index>

* [`getLatestVideoThumbnailFromAlbum(...)`](#getlatestvideothumbnailfromalbum)
* [`openPhotosApp()`](#openphotosapp)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### getLatestVideoThumbnailFromAlbum(...)

```typescript
getLatestVideoThumbnailFromAlbum(options: GetLatestVideoThumbnailFromAlbumOptions) => Promise<GetLatestVideoThumbnailFromAlbumResults>
```

Returns a thumbnail from the newest video in a specific album

| Param         | Type                                                                                                        | Description                                                                                                               |
| ------------- | ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#getlatestvideothumbnailfromalbumoptions">GetLatestVideoThumbnailFromAlbumOptions</a></code> | – The album name and the size of the resulting thumbnail. The album name is not supported and will be ignored on Android. |

**Returns:** <code>Promise&lt;<a href="#getlatestvideothumbnailfromalbumresults">GetLatestVideoThumbnailFromAlbumResults</a>&gt;</code>

--------------------


### openPhotosApp()

```typescript
openPhotosApp() => Promise<void>
```

Opens the photos app of the phone

--------------------


### Interfaces


#### GetLatestVideoThumbnailFromAlbumResults

| Prop        | Type                |
| ----------- | ------------------- |
| **`value`** | <code>string</code> |


#### GetLatestVideoThumbnailFromAlbumOptions

| Prop            | Type                                                    |
| --------------- | ------------------------------------------------------- |
| **`albumName`** | <code>string</code>                                     |
| **`size`**      | <code><a href="#thumbnailsize">ThumbnailSize</a></code> |


#### ThumbnailSize

| Prop         | Type                |
| ------------ | ------------------- |
| **`width`**  | <code>number</code> |
| **`height`** | <code>number</code> |

</docgen-api>
