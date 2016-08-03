app/helpers/*.rb
=================
This is your helper folder. Helper supports DRY (Don't Repeat Yourself) practices by allowing its methods
to be across the applications. Hence, repetitive methods or functions are encouraged to be placed inside
a helper file.

The helper can be created manually like controller file. To ensure the functions are working in the helpers,
any helper file should has the helpers loop. Example:
```
# app/helpers/html.rb
helpers do


end
```