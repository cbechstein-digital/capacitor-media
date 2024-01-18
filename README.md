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


## API

<docgen-index>

* [`getLatestVideoThumbnailFromAlbum(...)`](#getlatestvideothumbnailfromalbum)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### getLatestVideoThumbnailFromAlbum(...)

```typescript
getLatestVideoThumbnailFromAlbum(options: GetLatestVideoThumbnailFromAlbumOptions) => Promise<GetLatestVideoThumbnailFromAlbumResults>
```

Returns a thumbnail from the newest video in a specific album

| Param         | Type                                                                                                        | Description                                               |
| ------------- | ----------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| **`options`** | <code><a href="#getlatestvideothumbnailfromalbumoptions">GetLatestVideoThumbnailFromAlbumOptions</a></code> | – The album name and the size of the resulting thumbnail. |

**Returns:** <code>Promise&lt;<a href="#getlatestvideothumbnailfromalbumresults">GetLatestVideoThumbnailFromAlbumResults</a>&gt;</code>

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
