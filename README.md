# widgetbook_screenutil_bug


## Bug
There is a bug in `widgetbook` + `screenutil` that happens when a widget rebuilds.

## Reproduction
- Create a stateful widget
- Add image with `.w` and `.h` sizes
- Trigger the `setState`

Example 

![Kapture 2023-03-20 at 09 19 24](https://user-images.githubusercontent.com/19389850/226242602-f9a77f47-3a8b-49e7-87b9-0ef5118ce418.gif)
