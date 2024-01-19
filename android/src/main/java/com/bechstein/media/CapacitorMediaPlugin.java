package com.bechstein.media;

import android.Manifest;
import android.content.ActivityNotFoundException;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.media.ThumbnailUtils;
import android.net.Uri;
import android.os.Build;
import android.provider.MediaStore;
import android.util.Base64;
import android.util.Log;
import android.util.Size;

import com.getcapacitor.JSObject;
import com.getcapacitor.PermissionState;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.annotation.Permission;
import com.getcapacitor.annotation.PermissionCallback;

import java.io.ByteArrayOutputStream;

@CapacitorPlugin(
        name = "CapacitorMedia",
        permissions = {
                @Permission(
                        alias = "publicStorage",
                        strings = { Manifest.permission.READ_EXTERNAL_STORAGE }
                ),
                @Permission(
                        alias = "publicStorage13Plus",
                        strings = { Manifest.permission.READ_MEDIA_VIDEO }
                )
        }
)
public class CapacitorMediaPlugin extends Plugin {
    private static final String TAG = "CapacitorMediaPlugin";

    @PluginMethod
    public void getLatestVideoThumbnailFromAlbum(PluginCall call) {
        if (isStoragePermissionGranted()) {
            _getLatestVideoThumbnailFromAlbum(call);
        } else {
            requestAllPermissions(call, "permissionCallback");
        }
    }

    @PluginMethod
    public void openPhotosApp(PluginCall call) {
        Intent intent = new Intent(Intent.ACTION_VIEW, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        try {
            getContext().startActivity(intent);
            call.resolve();
        } catch (Exception e) {
            Log.d(TAG, e.getMessage());
            call.reject("The photos app could not be opened");
            return;
        }
    }

    @PermissionCallback
    private void permissionCallback(PluginCall call) {
        if (!isStoragePermissionGranted()) {
            call.reject("Unable to do file operation, user denied permission request");
            return;
        }

        switch (call.getMethodName()) {
            case "getLatestVideoThumbnailFromAlbum" -> _getLatestVideoThumbnailFromAlbum(call);
        }
    }

    private boolean isStoragePermissionGranted() {
        String permissionSet = "publicStorage";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            permissionSet = "publicStorage13Plus";
        }

        return getPermissionState(permissionSet) == PermissionState.GRANTED;
    }

    private void _getLatestVideoThumbnailFromAlbum(PluginCall call) {
        String albumName = call.getString("albumName");
        if (albumName == null) {
            call.reject("Album name is required.");
            return;
        }
        JSObject size = call.getObject("size", new JSObject());
        Integer width = size.getInteger("width");
        if (width == null) {
            call.reject("Width is required.");
            return;
        }
        Integer height = size.getInteger("height");
        if (height == null) {
            call.reject("Height is required.");
            return;
        }

        Log.d(TAG, "Querying video for album: " + albumName);

        String[] projection = {
                MediaStore.Video.Media._ID,
                MediaStore.Video.Media.DISPLAY_NAME,
                MediaStore.Video.Media.DATE_ADDED
        };
        String sortOrder = MediaStore.Video.Media.DATE_ADDED + " DESC";

        ContentResolver contentResolver = getContext().getContentResolver();

        try (Cursor cursor = contentResolver.query(
                MediaStore.Video.Media.EXTERNAL_CONTENT_URI,
                projection,
                null,
                null,
                sortOrder
        )) {
            if (cursor != null && cursor.moveToFirst()) {
                int idColumn = cursor.getColumnIndexOrThrow(MediaStore.Video.Media._ID);
                long id = cursor.getLong(idColumn);
                Uri contentUri = ContentUris.withAppendedId(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, id);

                Bitmap thumbnail = null;

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    thumbnail =
                            getContext().getContentResolver().loadThumbnail(
                                    contentUri, new Size(width, height), null);
                } else {
                    String path = contentUri.getPath();
                    if (path != null) {
                        thumbnail = ThumbnailUtils.createVideoThumbnail(path, MediaStore.Images.Thumbnails.MINI_KIND);
                    }
                }

                if (thumbnail == null) {
                    call.reject("Thumbnail return null");
                    return;
                }

                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                thumbnail.compress(Bitmap.CompressFormat.JPEG, 100, byteArrayOutputStream);
                byte[] byteArray = byteArrayOutputStream .toByteArray();
                String encoded = "data:image/jpeg;base64," + Base64.encodeToString(byteArray, Base64.DEFAULT);
                Log.d(TAG, encoded);
                JSObject ret = new JSObject();
                ret.put("value", encoded);
                call.resolve(ret);

            } else {
                call.reject("Cursor return null");
                return;
            }
        } catch (Exception e) {
            call.reject("Could not query video assets");
            return;
        }
    }

}
