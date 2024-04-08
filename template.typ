#let jarticle(
  fontsize: 11pt,
  title: none,
  authors: (),
  abstract: [],
  date: none,
  doc,
) = {
  let roman = "STIX Two Text"
  let mincho = "Harano Aji Mincho"
  let kakugothic = "Harano Aji Gothic"
  let math_font = "STIX Two Math"

  set text(lang:"ja", font: (roman,mincho), fontsize)

  //　Use A4 paper
  set page(
    paper: "a4",
    margin: auto,
  )
  set par(justify: true)

  // 行間の調整
  set par(
  leading: 1.2em,
  justify: true,
  first-line-indent: 1.1em,
  )
  show par: set block(spacing: 1.2em)
  show heading: set block(above: 1.6em, below: 0.6em)
  set heading(numbering: "1.1     ")
// 見出しの下の段落を字下げするため
  show heading: it =>{
    it
    par(text(size: 0pt, ""))
  }
// 様々な場所でのフォント
  show heading: set text(font: kakugothic)
  show strong: set text(font: kakugothic)
  show emph: set text(font: (roman, kakugothic))
  show math.equation: set text(font: (math_font,roman,mincho)) 

// 数式番号
  set math.equation(numbering: "(1)")
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      )
    } else {
      // Other references as usual.
      it
    }
  }

// 図のキャプション
  set figure(gap: 1.6em)
  show figure.caption: it => [
    #block(width: 90%, [#it])
    #v(1em)
  ]
  show figure.caption: set text(font: kakugothic, 
  0.9*fontsize)
  show figure.caption: set align(left)
  // タイトル
  set align(center)
  text(1.5*fontsize, font:kakugothic, strong(title))
 
　 　par(for a in authors {a})

  par(date)

  if abstract != [] {
  par(text(0.9*fontsize,[
   *概要*
   
  #block(width: 90%)[#align(left, abstract)]
  ]))
  }
  
  set align(left)
  doc
}

#let appendix(app) = [
    #counter(heading).update(0)
    #set heading(numbering: "A.1     ")
    #app
]

#let 年月日 = "[year]年[month repr:numerical padding:none]月[day]日"