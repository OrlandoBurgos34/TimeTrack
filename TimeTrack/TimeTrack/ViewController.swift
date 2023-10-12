//
//  ViewController.swift
//  TimeTrack
//
//  Created by Daniel Apps on 5/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
    }
    
    var timerClock = Timer()
    var isRunningTime = false
    var elapsedTime = 0.0
    var recordedTimes: [Double] = []
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        starTime()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        if isRunningTime {
            // Detener el cronómetro solo si está en funcionamiento.
            timerClock.invalidate()
            isRunningTime = false
            recordedTimes.append(elapsedTime)
            updateRecordedTimesUI()
        }
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
            elapsedTime = 0.0
            timerClock.invalidate()
            timeLabel.text = "00:00"
        }
    
    @IBOutlet weak var TiempoRegistrado: UILabel!
    
    @IBAction func controlViewTime(_ sender: UIButton) {
        if !recordedTimes.isEmpty {
            var timesList = ""
            for (index, time) in recordedTimes.enumerated() {
                let minutes = Int(time) / 60
                let seconds = Int(time) % 60
                let formattedTime = String(format: "%02d:%02d", minutes, seconds)
                timesList += "\(index + 1). \(formattedTime)\n"
            }
            TiempoRegistrado.text = timesList  // Actualiza el label con los tiempos registrados
        } else {
            TiempoRegistrado.text = "No hay tiempos registrados aún."  // Mensaje si no hay tiempos registrados
        }
            
                
    }
    
    
    //MARK: - Func Here
    
    func starTime() {
        timerClock.invalidate()
        // Iniciar cronometro
        timerClock = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return  }
            
            // Aumentar el tiempo transcurrido en 1 segundo
            self.elapsedTime += 1.0
            
            // formatear texto y actualizar label
            let minutes = Int(self.elapsedTime) / 60
            let seconds = Int(self.elapsedTime) % 60
            self.timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
        isRunningTime = true
    }
    func updateRecordedTimesUI() {
        
        var timesList = ""
        for (index, time) in recordedTimes.enumerated() {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
            timesList += "\(index + 1). \(formattedTime)\n"
        }
        TiempoRegistrado.text = timesList
    }
}
