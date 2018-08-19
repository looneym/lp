# LastPass CLI search

A simple command line interface for LastPass password manager. Search account by name and copy passwords to system clipboard. 

Example usage:

```ruby
[1] pry(main)> i = Interface.new
[2] pry(main)> i.search "github"
0 : github.com
Enter index
0
Password copied to clipboard!
```

TODO
- Cache username
- Package as Gem
- Obfuscate password input
- Tests
