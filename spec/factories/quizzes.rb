FactoryBot.define do
  factory :quiz do
    training
    questions { 
      [
        { 
          question: "What is 2+2?", 
          options: ["3", "4", "5"], 
          correct: "4" 
        }
      ] 
    }
  end
end
