# Swift-Pickers-Guide
A work-in-progress on how to use item and date pickers in Swift

This guide started as a research into pickers to be used in my 
final project for CS50. The project was at this time about 80 %
done and I was still pretty green on Swift. So I needed a place 
to experiment without messing up my existing code.

I decided to make my experiment into a guide that I can use for
future projects.

Great if anyone else might find my code and notes notes helpful.

This is a work-in-progress. Although it all functions as I intended,
I might learn some tweaks to improve the code as I get more experience
with Swift. Or improvements might derive from feedback on my CS50 
project.

# What is it all about?

I had a ViewController where I was updating 2 fields with valid items
from 2 different lists. When user parked on one field, a PickerView
should let the user select from the related list. Another field should 
populate the PickerView with items from another list.
The PickerView should find and focus on the item that already matched
the value in the input field (updated earlier or in the CS50 project 
retrieved from database)
