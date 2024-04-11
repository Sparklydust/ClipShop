# ClipShop

ClipShop is an iOS application developed as an assessment test for Leboncoin. This app is crafted 
in the Swift language and designed for iPhone and iPad devices using iOS 14 as a minimum target.

## Overview

ClipShop is an application tailored for browsing and discovering paperclip products.

## Features

- Supports both iPhone and iPad on iOS 14 and above.
- A MVVM architecture for the separation of concerns.
- UIKit framework for the UI/UX.
- Fetches and displays REST API requests for a list and details of items.
- Filter by category and sort listings, with priority given to urgent items.
- Presents a detailed view with information for the selected item.

## Architecture

ClipShop uses a MVVM (Model-View-ViewModel) architecture pattern, focusing on the separation of logic and
presentation. It enables the use of dependencies injection to separate logic through protocols for testing.

## Installation

To run ClipShop, clone the repository and open the project using at least Xcode 15. The application is ready 
to run on any device or simulator supporting iOS 14+.

## Requirements

- Create a universal application (iPhone, iPad) in Swift.
- Display a list of announcements available on the API https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json
- Category IDs mapping available on the API https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json
- API contract viewable at https://raw.githubusercontent.com/leboncoin/paperclip/master/swagger.yaml

Expected in the project:
- Architecture respecting the single responsibility principle.
- Interface creation with Auto Layout directly in code (no storyboard, xib, or SwiftUI).
- Development in Swift.
- Versioned code (Git) on an online platform like Github or Bitbucket (no zip) and immediately executable 
on the master branch.
- No external libraries allowed.
- Project compatibility for iOS 14+ (compilation and testing).
- Within the list of items, each one must include at least an image, a category, a title, and a price.
- An indicator must also alert if the item is urgent.
- A filter must be available to display only items from a category with the list.
- Items must be sorted by date, with urgent ads moving to the top of the list.
- Tapping on an item should display a detailed view with all the information provided in the API.

## License

ClipShop is available under the MIT license.

## Contact

Reach out to roland.lariotte@gmail.com
