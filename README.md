# JARL (Just Another Ruby Linter)
This is the final project for the Ruby module in the Microverse's full-stack remote developer program

JARL is a beginner level linter that checks ruby .rb code files for the following rules:
- Maximum 100 lines per file
- Maximum 80 characters per code line
- Use of two spaces of indentation.
- Exception in the line after a guard clause
- No trailing spaces
- Lack of EOF empty line

# Video Presentation
 You can see a video with the presentation of this project by clicking [here](https://www.loom.com/share/b3c72e55c5ba454ab53f12359fd6c9f1) 

![JARL](https://user-images.githubusercontent.com/53324035/77028766-ca9c2480-6967-11ea-967e-af28c3ae413b.png)

# Examples

**Max. 80 characters per line**

_\# Bad_
```ruby
    if extra_large_condition1 && extra_large_condition2 && extra_large_condition3 && extra_large_condition4
```
_\# Good_
```ruby
    if extra_large_condition1 && extra_large_condition2 &&
      extra_large_condition3 && extra_large_condition4
```
**Use of two spaces of indentation**

_\# Bad_
```ruby
        name = 'Carlos'
        if name.length > 4
            puts "Hello #{name}!" # tab or more than 2 spaces 
        end
```
_\# Good_
```ruby
        name = 'Carlos'
        if name.length > 4
          puts "Hello #{name}!"
        end
```
**Exception in the line after a guard clause**

_\# Good_
```ruby
        return unless File.exists?('file_name')
                          # empty line indentation can be 0 even if previous line is 4
        some other code
 ```
 **No trailing spaces**

_\# Bad_
```ruby
        puts 'Hello, world!' # invisible trailing space here
```
_\# Good_
```ruby
        puts 'Hello, world!'  # the line ends with the last single quote
```
**Missing  EOF empty line**

_\# Bad_
```ruby
        name = 'Carlos'
        if name.length > 4
          puts "Hello #{name}!"
        end # file ends here
```
_\# Good_
```ruby
        name = 'Carlos'
        if name.length > 4
          puts "Hello #{name}!"
        end
        # file ends here
```
# Getting started

To get a local copy of this repository up and running, follow these steps: 

- Click the **"Clone or download"** button
- Copy the URL of the repository. 
- Go to the terminal on your local machine and type: **git clone** 
- Paste the URL you copied before. 
- Change your local directory by typing **cd Ruby-capstone-project**
- Type **ruby bin/main.rb** and press **[Enter]**

# Usage

You can either run the main.rb script without arguments for linting all the .rb ruby code files,
(including subdirectories) or pass a single filename as an argument to lint that specific file.  

# Prerequisites
  
 You must have Ruby [installed on your computer](https://www.ruby-lang.org/en/documentation/installation/)
 
 # Built with

- Ruby
- RSpec
- VSCode
 
 # Running the tests

For running the automated tests type **rspec spec/linter_spec.rb** in the root
directory of the project
 
 # Author
 
 👤 Carlos Santamaría

* Twitter: [@Flakster ](https://twitter.com/Flakster )
* Github: [@Flakster](https://github.com/Flakster)
* Email: contact@carlossantamaria.co

# 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page.](https://github.com/Flakster/Ruby-capstone-project/issues)

# Show your support

Give a 🌟 if you like this project!

# 📝 License

 This project is licensed under the [GNU General Public License v3.0](https://github.com/Flakster/Ruby-capstone-project/blob/linter/LICENSE)

  
