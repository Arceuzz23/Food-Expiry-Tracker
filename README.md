# Assignment 1: Food Waste Reduction Feature

**Background:**
At Expyr, we're committed to helping users reduce food waste. While our app currently tracks food items and their expiry dates, we want to understand what happens to these items. Did they get consumed in time? Were they wasted? This data can help users better understand their consumption patterns.

**Your Task:**
Design and implement a feature that allows users to mark food items as consumed. This should help users:
1. Keep track of what they've actually eaten
2. Distinguish between consumed items and potentially wasted items
3. Review their consumption history

**Core Requirements:**
1. Users should be able to mark any food item as "consumed"
2. Consumed items should be moved to a separate list/view
3. The UI should clearly distinguish between available and consumed items
4. Users should be able to view their consumption history

**Technical Notes:**
- The app uses Provider for state management
- A mock data service is provided to simulate backend operations
- Focus on maintaining a clean, intuitive user experience

**Evaluation Criteria:**
1. **Architecture & Design (40%)**
   - How well does your solution fit into the existing architecture?
   - How maintainable and extensible is your code?
   - How do you handle edge cases?

2. **User Experience (30%)**
   - Is the feature intuitive to use?
   - How do you handle loading states and errors?
   - Are the UI transitions smooth?

3. **Code Quality (30%)**
   - Is your code well-organized and documented?
   - Are your commits clear and logical?
   - How well do you handle error cases?


**Getting Started:**
1. The base code provides a simple food tracking app
2. Run `flutter run` to see the current state

**Submission:**
- Include a brief explanation of your design decisions
- Deadline: 1 day from assignment date

**Questions to Consider:**
1. How will users distinguish between available and consumed items?
2. What happens to expiry tracking once an item is marked as consumed?
3. How would you handle accidental "consumed" marks?
4. How might this feature evolve in future versions?

Feel free to ask questions if anything is unclear. Good luck!


Assignment/1/
├── lib/
│   ├── models/
│   │   └── item_data.dart
│   ├── providers/
│   │   └── items_provider.dart
│   ├── screens/
│   │   ├── consumed_items_screen.dart  (NEW)
│   │   └── dashboard_screen.dart      (Simplified, for context)
│   ├── widgets/
│   │   └── item_card.dart             (Simplified, for context)
│   ├── services/
│   │   └── mock_firestore_service.dart (NEW)
│   └── main.dart
└── README.md