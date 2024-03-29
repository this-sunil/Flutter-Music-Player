package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
      com.mtechviral.musicfinder.MusicFinderPlugin.registerWith(shimPluginRegistry.registrarFor("com.mtechviral.musicfinder.MusicFinderPlugin"));
      com.example.medianotification.MediaNotificationPlugin.registerWith(shimPluginRegistry.registrarFor("com.example.medianotification.MediaNotificationPlugin"));
    flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    flutterEngine.getPlugins().add(new com.tekartik.sqflite.SqflitePlugin());
      com.example.systemshortcuts.SystemShortcutsPlugin.registerWith(shimPluginRegistry.registrarFor("com.example.systemshortcuts.SystemShortcutsPlugin"));
    flutterEngine.getPlugins().add(new com.example.volume.VolumePlugin());
  }
}
