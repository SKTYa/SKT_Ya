//
//  Audio.swift
//  Lingua
//
//  Created by 김다빈 on 2023/09/01.
//

import AVFoundation
import Foundation

class AudioRecorderManger: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    //음성메모 녹음 관련 프로퍼티
    var audioRecorder: AVAudioRecorder?
    @Published var isRecording = false
    
    // 음성메모 재생 관련 프로퍼티
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var isPaused = false
    
    // 음성메모된 데이터
    var recordedFiles = [URL]()
    
}

// MARK: - 음성메모 녹음 관련 메서드
extension AudioRecorderManger {
    func startRecording() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("inputAudio.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.record()
            self.isRecording = true
        } catch {
            print("녹음 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        self.recordedFiles.append(self.audioRecorder!.url)
        self.isRecording = false
        
        let sourceURL = getDocumentsDirectory().appendingPathComponent("inputAudio.m4a")
        print(sourceURL)
        let destinationURL = getDocumentsDirectory().appendingPathComponent("recordedAudio.m4a")
        
        do {
            // 녹음이 끝난 후 파일 다
            try FileManager.default.moveItem(at: sourceURL, to: destinationURL)
            print("저장 파일 위치: \(destinationURL)")
            self.recordedFiles.append(destinationURL)
        } catch {
            print("Save recorded file error: \(error.localizedDescription)")
        }
    }

    
    func stopRecording2() {
        audioRecorder?.stop()
        self.recordedFiles.append(self.audioRecorder!.url)
        self.isRecording = false
        
        do {
            try FileManager.default.moveItem(at: getDocumentsDirectory().appendingPathComponent("inputAudio.m4a"), to: getDocumentsDirectory().appendingPathComponent("inputAudio.m4a"))
            print("저장 파일 위치: \(getDocumentsDirectory().appendingPathComponent("inputAudio.m4a"))")
            self.recordedFiles.append(getDocumentsDirectory().appendingPathComponent("inputAudio.m4a"))
        } catch {
            print("Save recorded file error: \(error.localizedDescription)")
        }
        
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    

}


