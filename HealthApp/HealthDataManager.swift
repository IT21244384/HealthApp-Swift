//
//  HealthDataManager.swift
//  HealthApp
//
//  Created by IM Student on 2024-11-29.
//

import HealthKit

class HealthDataManager {
    let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let dataTypes = Set([stepCount, heartRate])
        
        healthStore.requestAuthorization(toShare: [], read: dataTypes) { success, _ in
            completion(success)
        }
    }
    
    func fetchStepCount(completion: @escaping (Double) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: nil, options: .cumulativeSum) { _, result, _ in
            let stepCount = result?.sumQuantity()?.doubleValue(for: .count()) ?? 0
            DispatchQueue.main.async {
                completion(stepCount)
            }
        }
        healthStore.execute(query)
    }
    
    func fetchHeartRate(completion: @escaping (Double) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: nil) { _, samples, _ in
            guard let sample = samples?.first as? HKQuantitySample else {
                completion(0)
                return
            }
            let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
            DispatchQueue.main.async {
                completion(heartRate)
            }
        }
        healthStore.execute(query)
    }
}
