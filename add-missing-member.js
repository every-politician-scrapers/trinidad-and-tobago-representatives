module.exports = (label) => {
  return {
    type: 'item',
    labels: {
      en: label,
    },
    descriptions: {
      en: 'politician in Trinidad and Tobago',
    },
    claims: {
      P31: { value: 'Q5' }, // human
      P106: { value: 'Q82955' }, // politician
      P39: {
        value: 'Q18719159',
        qualifiers: {
          P2937: 'Q107504455'
        },
        references: {
          P854: 'http://www.ttparliament.org/members.php?mid=54'
        },
      }
    }
  }
}
