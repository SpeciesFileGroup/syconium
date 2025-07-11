# Syconium

Syconium is a Ruby wrapper on the [OpenAlex](https://openalex.org) API. Code follow the spirit/approach of the Gem [serrano](https://github.com/sckott/serrano), and indeed much of the wrapping utility is copied 1:1 from that repo, thanks [@sckott](https://github.com/sckott).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'syconium'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install syconium

## Usage

To use the OpenAlex API via the Syconium Ruby gem, you must supply either your email address or your api_key. Providing your email helps OpenAlex get in touch with your if there is a problem with your software.

### Pagination

For pagination, you can browse up to 10,000 results with the page and per_page parameters:
```ruby
Syconium.works(email: "your_email@example.com", page: 5, per_page:25) #  => Hash
```

Beyond 10,000 results it is strongly recommended to use the [data snapshot](https://docs.openalex.org/download-all-data/openalex-snapshot) instead of the API, but you can also use a cursor, which you can request with a *:
```ruby
Syconium.works(email: "your_email@example.com", per_page:1, cursor="*") #  => Hash
```
The metadata will contain the next_cursor to browse the next page:
```ruby
Syconium.works(email: "your_email@example.com", per_page:1, cursor="IlsxMDAuMCwgNTM2NCwgJ2h0dHBzOi8vb3BlbmFsZXgub3JnL1czMDEwNDQxNzMyJ10i")
```


### Endpoints

All of the endpoints (authors, funders, keywords, institutions, publishers, sources, topics, works) are wrapped and function similarly.

#### [Authors](https://docs.openalex.org/api-entities/authors)

List authors:
```ruby
Syconium.authors() #  => Hash
```

Search authors:
```ruby
Syconium.authors(email: "your_email@example.com", search: "Smith") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.authors(email: "your_email@example.com", autocomplete: true, q: "Smi") #  => Hash
Syconium.authors(email: "your_email@example.com", autocomplete: true, q: "Smi", search: "John") #  => Hash
```

Filter authors by [attributes](https://docs.openalex.org/api-entities/authors/filter-authors):
```ruby
Syconium.authors(email: "your_email@example.com", filter: 'has_orcid:true') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/authors/group-authors):
```ruby
Syconium.authors(email: "your_email@example.com", group_by: 'has_orcid') #  => Hash
```

Get an author by ID:
```ruby
Syconium.authors(email: "your_email@example.com", id: 'A1234567') #  => Hash
Syconium.authors(email: "your_email@example.com", id: 'orcid:0000-0000-0000-0000') #  => Hash
```

Get a random author:
```ruby
Syconium.authors(email: "your_email@example.com", random: true) #  => Hash
```

Get a random sample of 25 authors:
```ruby
Syconium.authors(email: "your_email@example.com", sample: 25) #  => Hash
```

#### [Concepts](https://docs.openalex.org/api-entities/concepts)
The concepts endpoints should work, but they are depreciated/unmaintained so it is recommended to use Topics instead.


#### [Funders](https://docs.openalex.org/api-entities/funders)

List funders:
```ruby
Syconium.funders() #  => Hash
```

Search funders:
```ruby
Syconium.funders(email: "your_email@example.com", search: "Smith") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.funders(email: "your_email@example.com", autocomplete: true, q: "Nationa") #  => Hash
Syconium.funders(email: "your_email@example.com", autocomplete: true, q: "Nationa", search: "Biodiversity") #  => Hash
```

Filter funders by [attributes](https://docs.openalex.org/api-entities/funders/filter-funders):
```ruby
Syconium.funders(email: "your_email@example.com", filter: 'country_code:ca') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/funders/group-funders):
```ruby
Syconium.funders(email: "your_email@example.com", group_by: 'country_code') #  => Hash
```

Get a funder by ID:
```ruby
Syconium.funders(email: "your_email@example.com", id: 'F4320306076') #  => Hash
Syconium.funders(email: "your_email@example.com", id: 'ror:021nxhr62') #  => Hash
```

Get a random funders:
```ruby
Syconium.funders(email: "your_email@example.com", random: true) #  => Hash
```

Get a random sample of 25 funders:
```ruby
Syconium.funders(email: "your_email@example.com", sample: 25) #  => Hash
```


#### [Institutions](https://docs.openalex.org/api-entities/institutions)

List institutions:
```ruby
Syconium.institutions() #  => Hash
```

Search institutions:
```ruby
Syconium.institutions(email: "your_email@example.com", search: "biodiversity") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.institutions(email: "your_email@example.com", autocomplete: true, q: "biodiv") #  => Hash
Syconium.institutions(email: "your_email@example.com", autocomplete: true, q: "greenhou", search: "frogs") #  => Hash
```

Filter institutions by [attributes](https://docs.openalex.org/api-entities/institutions/filter-institutions):
```ruby
Syconium.institutions(email: "your_email@example.com", filter: 'is_oa:true') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/institutions/group-institutions):
```ruby
Syconium.institutions(email: "your_email@example.com", group_by: 'oa_status') #  => Hash
```

Get an institution by ID:
```ruby
Syconium.institutions(email: "your_email@example.com", id: 'I157725225') #  => Hash
Syconium.institutions(email: "your_email@example.com", id: 'ror:047426m28') #  => Hash
```

Get a random institution:
```ruby
Syconium.institutions(email: "your_email@example.com", random: true) #  => Hash
```

Get a random sample of 25 institutions:
```ruby
Syconium.institutions(email: "your_email@example.com", sample: 25) #  => Hash
```

#### [Keywords](https://docs.openalex.org/api-entities/keywords)

List keywords:
```ruby
Syconium.keywords() #  => Hash
```

Search keywords:
```ruby
Syconium.keywords(email: "your_email@example.com", search: "biodiversity") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.keywords(email: "your_email@example.com", autocomplete: true, q: "biodiv") #  => Hash
Syconium.keywords(email: "your_email@example.com", autocomplete: true, q: "ani", search: "evolution")) #  => Hash
```

Filter keywords by [attributes](https://docs.openalex.org/api-entities/keywords):
```ruby
Syconium.keywords(email: "your_email@example.com", filter: 'works_count:1') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/keywords):
```ruby
Syconium.keywords(email: "your_email@example.com", group_by: 'cited_by_count') #  => Hash
```

Get a keywords by ID:
```ruby
Syconium.keywords(email: "your_email@example.com", id: 'biodiversity-conservation') #  => Hash
```

Get a random sample of 5 keywords:
```ruby
Syconium.keywords(email: "your_email@example.com", sample: 25) #  => Hash
```


#### [Publishers](https://docs.openalex.org/api-entities/publishers)

List publishers:
```ruby
Syconium.publishers() #  => Hash
```

Search publishers:
```ruby
Syconium.publishers(email: "your_email@example.com", search: "biodiversity") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.publishers(email: "your_email@example.com", autocomplete: true, q: "biodiv") #  => Hash
Syconium.publishers(email: "your_email@example.com", autocomplete: true, q: "greenhou", search: "frogs") #  => Hash
```

Filter publishers by [attributes](https://docs.openalex.org/api-entities/publishers/filter-publishers):
```ruby
Syconium.publishers(email: "your_email@example.com", filter: 'hierarchy_level:0') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/publishers/group-publishers):
```ruby
Syconium.publishers(email: "your_email@example.com", group_by: 'country_codes') #  => Hash
```

Get a publishers by ID:
```ruby
Syconium.publishers(email: "your_email@example.com", id: 'P4310315930') #  => Hash
Syconium.publishers(email: "your_email@example.com", id: 'ror:047426m28') #  => Hash
```

Get a random publishers:
```ruby
Syconium.publishers(email: "your_email@example.com", random: true) #  => Hash
```

Get a random sample of 25 publishers:
```ruby
Syconium.publishers(email: "your_email@example.com", sample: 25) #  => Hash
```


#### [Sources](https://docs.openalex.org/api-entities/sources)
Sources are where works are hosted and include several types: conferences, journals, preprint repositories, institutional repositories, etc.

List sources:
```ruby
Syconium.sources() #  => Hash
```

Search sources:
```ruby
Syconium.sources(email: "your_email@example.com", search: "biodiversity") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.sources(email: "your_email@example.com", autocomplete: true, q: "eco") #  => Hash
Syconium.sources(email: "your_email@example.com", autocomplete: true, q: "eco", search: "biodiversity") #  => Hash
```

Filter sources by [attributes](https://docs.openalex.org/api-entities/sources/filter-sources):
```sources
Syconium.sources(email: "your_email@example.com", filter: 'is_oa:true') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/sources/group-sources):
```ruby
Syconium.sources(email: "your_email@example.com", group_by: 'oa_status') #  => Hash
```

Get a sources by ID:
```ruby
Syconium.sources(email: "your_email@example.com", id: 'S4306402618') #  => Hash
Syconium.sources(email: "your_email@example.com", id: 'issn:1314-2828') #  => Hash
```

Get a random source:
```ruby
Syconium.sources(email: "your_email@example.com", random: true) #  => Hash
```

Get a random sample of 25 sources:
```ruby
Syconium.sources(email: "your_email@example.com", sample: 25) #  => Hash
```


#### [Topics](https://docs.openalex.org/api-entities/topics)

List topics:
```ruby
Syconium.topics() #  => Hash
```

Search topics:
```ruby
Syconium.topics(email: "your_email@example.com", search: "biodiversity") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.topics(email: "your_email@example.com", autocomplete: true, q: "biodiv") #  => Hash
Syconium.topics(email: "your_email@example.com", autocomplete: true, q: "greenhou", search: "frogs") #  => Hash
```

Filter topics by [attributes](https://docs.openalex.org/api-entities/topics/filter-topics):
```ruby
Syconium.topics(email: "your_email@example.com", filter: 'subfield.id:1311') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/topics/group-topics):
```ruby
Syconium.topics(email: "your_email@example.com", group_by: 'subfield.id') #  => Hash
```

Get a topics by ID:
```ruby
Syconium.topics(email: "your_email@example.com", id: 'T10319') #  => Hash
```

Get a random topics:
```ruby
Syconium.topics(email: "your_email@example.com", random: true) #  => Hash
```

Get a random sample of 25 works:
```ruby
Syconium.topics(email: "your_email@example.com", sample: 25) #  => Hash
```


#### [Works](https://docs.openalex.org/api-entities/works)

List works:
```ruby
Syconium.works() #  => Hash
```

Search works:
```ruby
Syconium.works(email: "your_email@example.com", search: "biodiversity") #  => Hash
```

For autocomplete, use the q parameter as the autocomplete field and also optionally you can use the filter and search parameters:
```ruby
Syconium.works(email: "your_email@example.com", autocomplete: true, q: "biodiv") #  => Hash
Syconium.works(email: "your_email@example.com", autocomplete: true, q: "greenhou", search: "frogs") #  => Hash
```

Filter works by [attributes](https://docs.openalex.org/api-entities/works/filter-works):
```ruby
Syconium.works(email: "your_email@example.com", filter: 'is_oa:true') #  => Hash
```

Group results by [attributes](https://docs.openalex.org/api-entities/works/group-works):
```ruby
Syconium.works(email: "your_email@example.com", group_by: 'oa_status') #  => Hash
```

Get a work by ID:
```ruby
Syconium.works(email: "your_email@example.com", id: 'pmid:33982150') #  => Hash
Syconium.works(email: "your_email@example.com", id: 'doi:10.48550/arXiv.2205.01833') #  => Hash
Syconium.works(email: "your_email@example.com", id: 'https://doi.org/10.48550/arXiv.2205.01833') #  => Hash
```

Get a random work:
```ruby
Syconium.works(email: "your_email@example.com", random: true) #  => Hash
```

Get a random sample of 25 works:
```ruby
Syconium.works(email: "your_email@example.com", sample: 25) #  => Hash
```


---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, update the `CHANGELOG.md`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/syconium. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SpeciesFileGroup/syconium/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT license](https://github.com/SpeciesFileGroup/syconium/blob/main/LICENSE.txt). You can learn more about the MIT license on [Wikipedia](https://en.wikipedia.org/wiki/MIT_License) and compare it with other open source licenses at the [Open Source Initiative](https://opensource.org/license/mit/).

## Code of Conduct

Everyone interacting in the Syconium project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SpeciesFileGroup/syconium/blob/main/CODE_OF_CONDUCT.md).
