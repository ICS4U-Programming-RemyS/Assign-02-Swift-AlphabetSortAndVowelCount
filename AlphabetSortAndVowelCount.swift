// AlphabetSortAndVowelCount.swift
//
// Created by Remy Skelton
// Created on 2025-April-9
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//
// This program will count the number of vowels in a string
// and sort the string in alphabetical order using bubble sort method.
// While taking the input from the input file and writing the output to
// the output file.

// Import Foundation
import Foundation

// Define the InputError enum to handle errors from 2-02
enum InputError: Error {
    case invalidInput
}

// Welcome message
print("Welcome to the Alphabet Sort and Vowel Count program!")
print("This program will count the number of vowels in a string "
+ "and sort the string in alphabetical order using bubble sort.")

// Define the input and output file paths
let inputFile = "./Assign-02-input.txt"
let outputFile = "./Assign-02-output.txt"

// Open the input file for reading from 2-02
guard let input = FileHandle(forReadingAtPath: inputFile) else {
    // Throw an error if the input file cannot be read
    throw InputError.invalidInput
}

// Open the output file for writing from 2-02
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    // Throw an error if the output file cannot be written to
    throw InputError.invalidInput
}

// Try to read from the input file
do {
    // Read the contents of the input file from 2-02
    let inputData = try String(contentsOfFile: inputFile, encoding: .utf8)
    // Split the input data into lines from 2-02
    let inputLines = inputData.split(separator: "\n")

    // Initialize lists to store words
    var listWords: [String] = []
    // Initialize lists to store vowel counts
    var listVowelCounts: [Int] = []
    // Initialize lists to store 'y' counts
    var listYCounts: [Int] = []

    // Loop through the lines and process words
    for line in inputLines {
        // Split the line into words
        let wordSubstrings = line.split(separator: " ")
        // Initialize an empty array to store words
        var words: [String] = []

        // Loop through each substring and convert it to a string
        for substring in wordSubstrings {
            words.append(String(substring))
        }

        // Loop through each word in the line
        for word in words {
            // Check if the word is not empty
            if !word.isEmpty {
                // Append the word to the list
                listWords.append(word)
                // Count the vowels and 'y' in the word
                let counts = countVowels(word: word)
                // Append the counts to the respective lists
                listVowelCounts.append(counts[0])
                listYCounts.append(counts[1])
            }
        }
    }

    // Call the bubble sort function to sort the words and their counts
    let sortedResults = bubbleSort(listWords: listWords, listVowelCounts: listVowelCounts, listYCounts: listYCounts)
    // Set the sorted words to the first element of the sorted results
    let sortedWords = sortedResults[0]
    // Set the sorted vowel counts to the second element of the sorted results
    let sortedVowelCounts = sortedResults[1]
    // Set the sorted 'y' counts to the third element of the sorted results
    let sortedYCounts = sortedResults[2]

    // Set the output string
    var outputStr = "Sorted words:\n"

    // Add each word on a new line
    for index in 0..<sortedWords.count {
        outputStr += "\(sortedWords[index])\n"
    }

    // Add a header for the vowel counts
    outputStr += "\nVowel count:\n"

    // Add vowel and 'y' counts for each word
    for index in 0..<sortedVowelCounts.count {
        outputStr +=
        "\(sortedWords[index]): \(sortedVowelCounts[index]) vowels and \(sortedYCounts[index]) number of y's\n"
    }

    // Write the output string to the output file from 2-02
    output.write(outputStr.data(using: .utf8)!)

    // Write the output string to the output file
    print("Successfully wrote to the output file.")
} catch {
    print("Error reading or writing file: \(error)")
}

// Function to count vowels and 'y' in a word
func countVowels(word: String) -> [Int] {
    // Initialize counts for vowels and 'y'
    var vowelCount = 0
    var yCount = 0

    // Convert the word to lowercase for case-insensitive comparison
    let wordLowercased = word.lowercased()

    // Loop through each character in the word
    for letter in wordLowercased {
        // Check each vowel individually
        if letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u" {
            vowelCount += 1
        }
        // Check if the letter is 'y'
        if letter == "y" {
            yCount += 1
        }
    }
    // Return the counts as an array
    return [vowelCount, yCount]
}

// Bubble sort function to sort words and their associated counts
func bubbleSort(listWords: [String], listVowelCounts: [Int], listYCounts: [Int]) -> [[String]] {
    // Recreate the lists to modify
    var listWords = listWords
    var listVowelCounts = listVowelCounts
    var listYCounts = listYCounts
    // For loop to iterate through the array
    for pass in 0..<listWords.count {
        // For loop to compare adjacent elements
        for index in 0..<listWords.count - pass - 1 {
            // Check if the current word is "greater" than the next word,
            if listWords[index].lowercased() > listWords[index + 1].lowercased() {
                // Swap the words
                let tempWord = listWords[index]
                listWords[index] = listWords[index + 1]
                listWords[index + 1] = tempWord

                // Swap the vowel counts
                let tempVowelCount = listVowelCounts[index]
                listVowelCounts[index] = listVowelCounts[index + 1]
                listVowelCounts[index + 1] = tempVowelCount

                // Swap the 'y' counts
                let tempYCount = listYCounts[index]
                listYCounts[index] = listYCounts[index + 1]
                listYCounts[index + 1] = tempYCount
            }
        }
    }

    // Convert the list of words to an array
    let sortedWords = listWords

    // Convert Int listVowelCounts to [String] using loops
    var sortedVowelCounts: [String] = []
    for count in listVowelCounts {
        sortedVowelCounts.append(String(count))
    }

    // Convert Int listYCounts to [String] using loops
    var sortedYCounts: [String] = []
    for count in listYCounts {
        sortedYCounts.append(String(count))
    }

    // Return the sorted arrays as a 2D array
    return [sortedWords, sortedVowelCounts, sortedYCounts]

}
