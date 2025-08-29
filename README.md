
# NEWYORK TIMES MOST POPULAR ARTICLES

This app aims to showcase the most popular articles using the NEWYORK public API. 

Toold


## Installation

Download direclty from github.


    
## FAQ

#### What is used in the development process?

Xcode, Swift & SwiftUI. 
MOYA for network & Combine. while keeping the documentation as a reference https://moya.github.io.

MOYA have been used with SPM. 
Postman was used to validate the API before starting the development process.

AI was used in some challanges, spicially in UnitTesting. 
#### what is the app minimum deployment? 

By default it uses the latest, and i kept it as is iOS 18.2.

#### Where is the API key stored?

You can find it in info.plist, under the name "NYT_API_KEY_TEST"
#### How is the project structured?

Models -> contains all DTOs i need, Services -> contains Networking helpers, Utils -> Contain imageLoader, ViewModels -> contains viewmodels used. Views -> contains screens and custom components. NewYorkTimesAppTests -> contains Unit testing.
## Lessons Learned

What did you learn while building this project? What challenges did you face and how did you overcome them?

I learned that moya is a very powerful tool that uses almofire. my biggest challange is Combine, and unit testing. but documentation, articles and AI helped a lot to get more fimiliar with, and naturally as any other tool, the more hands on the more i will be able to master it. 


## Screenshots

<img width="1728" height="1117" alt="Screenshot 2025-08-29 at 6 23 48 PM" src="https://github.com/user-attachments/assets/c004767c-04dc-4d8a-b84b-9f5b2e7f5cd6" />
<img width="1728" height="1117" alt="Screenshot 2025-08-29 at 8 02 44 PM" src="https://github.com/user-attachments/assets/3da030f9-a60f-44b3-a0f0-369b9eaba08c" />
<img width="1728" height="1117" alt="Screenshot 2025-08-29 at 8 02 40 PM" src="https://github.com/user-attachments/assets/c82e78fc-c55b-4033-a6f1-83b27d198e39" />


