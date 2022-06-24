import 'package:flutter/services.dart';
import 'package:record_platform_interface/src/record_platform_interface.dart';
import 'package:record_platform_interface/src/types/types.dart';

class MethodChannelRecord extends RecordPlatform {
  final MethodChannel _channel = const MethodChannel(
    'com.llfbandit.record',
  );

  @override
  Future<bool> hasPermission() async {
    final result = await _channel.invokeMethod<bool>('hasPermission');
    return result ?? false;
  }

  @override
  Future<bool> isPaused() async {
    final result = await _channel.invokeMethod<bool>('isPaused');
    return result ?? false;
  }

  @override
  Future<bool> isRecording() async {
    final result = await _channel.invokeMethod<bool>('isRecording');
    return result ?? false;
  }

  @override
  Future<void> pause() {
    return _channel.invokeMethod('pause');
  }

  @override
  Future<void> resume() {
    return _channel.invokeMethod('resume');
  }

  @override
  Future<void> start({
    String? path,
    Device? captureDevice,
    AudioEncoder encoder = AudioEncoder.aacLc,
    int bitRate = 128000,
    int samplingRate = 44100,
  }) {
    return _channel.invokeMethod('start', {
      "path": path,
      "encoder": encoder.name,
      "bitRate": bitRate,
      "samplingRate": samplingRate,
    });
  }

  @override
  Future<String?> stop() {
    return _channel.invokeMethod('stop');
  }

  @override
  Future<void> dispose() async {
    await _channel.invokeMethod('dispose');
  }

  @override
  Future<Amplitude> getAmplitude() async {
    final result = await _channel.invokeMethod('getAmplitude');

    return Amplitude(
      current: result?['current'] ?? 0.0,
      max: result?['max'] ?? 0.0,
    );
  }

  @override
  Future<List<Device>> getPlaybackDevices() async {
    return [];
  }

  @override
  Future<List<Device>> getCaptureDevices() async {
    return [];
  }

  @override
  Future<bool> isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _channel.invokeMethod<bool>(
      'isEncoderSupported',
      {'encoder': encoder.name},
    );

    return isSupported ?? false;
  }
}
