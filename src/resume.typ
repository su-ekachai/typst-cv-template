#import "../templates/lib.typ": *

#let profile = toml("../data/profile.toml")
#let exp = toml("../data/experience.toml")
#let projects = toml("../data/projects.toml")
#let skills = toml("../data/skills.toml")
#let edu = toml("../data/education.toml")

// Build the author dict, including optional contact fields only when non-empty
// (prevents stray "|" separators in the contact line).
#let author = (
  firstname: profile.firstname,
  lastname: profile.lastname,
  positions: profile.positions,
)
#for key in ("email", "phone", "github", "linkedin", "homepage", "address") {
  if profile.at(key, default: "") != "" {
    author.insert(key, profile.at(key))
  }
}

#show: resume.with(
  author: author,
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
  show-footer: false,
  show-address-icon: false,
  show-contact-icons: true,
  paper-size: "us-letter",
  contact-items-separator: box[#h(2pt)#text("|")#h(2pt)],
)

#let summary-text = profile.at("summary", default: "")
#if summary-text != "" {
  [= Summary]
  block(above: 0.5em, below: 0.9em)[
    #set text(size: 10pt, fill: rgb("#333333"))
    #summary-text
  ]
}

= Skills

#for cat in skills.category {
  let items = cat.at("strong", default: ()).map(s => strong(s)) + cat.at("items", default: ())
  resume-skill-item(cat.name, items)
}
#block(below: 0.65em)

= Experience

#for entry in exp.entry {
  resume-entry(
    title: entry.title,
    location: entry.at("location", default: ""),
    date: entry.at("date", default: ""),
    description: entry.at("company", default: ""),
    title-link: entry.at("link", default: none),
  )
  if entry.at("bullets", default: ()).len() > 0 {
    resume-item(entry.bullets.map(b => [- #b]).join())
  }
}

#if projects.at("entry", default: ()).len() > 0 {
  [= Projects]
  for entry in projects.entry {
    resume-entry(
      title: entry.title,
      location: if "github" in entry { github-link(entry.github) } else { "" },
      date: entry.at("date", default: ""),
      description: entry.at("role", default: ""),
    )
    if entry.at("bullets", default: ()).len() > 0 {
      resume-item(entry.bullets.map(b => [- #b]).join())
    }
  }
}

= Education

#for entry in edu.entry {
  resume-entry(
    title: entry.title,
    location: entry.at("location", default: ""),
    date: entry.at("date", default: ""),
    description: entry.at("degree", default: ""),
  )
  if entry.at("bullets", default: ()).len() > 0 {
    resume-item(entry.bullets.map(b => [- #b]).join())
  }
}
