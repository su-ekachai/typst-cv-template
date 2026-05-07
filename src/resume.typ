#import "../templates/lib.typ": *

#let profile = toml("../data/profile.toml")
#let exp = toml("../data/experience.toml")
#let projects = toml("../data/projects.toml")
#let skills = toml("../data/skills.toml")
#let edu = toml("../data/education.toml")

#show: resume.with(
  author: (
    firstname: profile.firstname,
    lastname: profile.lastname,
    email: profile.email,
    phone: profile.phone,
    github: profile.github,
    linkedin: profile.linkedin,
    homepage: profile.homepage,
    positions: profile.positions,
  ),
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
  show-footer: false,
  show-address-icon: true,
  paper-size: "us-letter",
  contact-items-separator: box[#h(2pt)#text("|")#h(2pt)],
)

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

= Projects

#for entry in projects.entry {
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

= Skills

#for cat in skills.category {
  let items = cat.at("strong", default: ()).map(s => strong(s)) + cat.at("items", default: ())
  resume-skill-item(cat.name, items)
}
#block(below: 0.65em)

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
