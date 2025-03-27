//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Bo on 3/26/25.
//


import Foundation

class TriviaQuestionService {
    func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        let urlString = "https://opentdb.com/api.php?amount=5&type=multiple"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse.results)
                    }
                } catch {
                    print("Decoding error: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
