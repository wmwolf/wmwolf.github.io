import re
from os.path import join

import ads

key = None

def make_url(paper):
    return 'https://ui.adsabs.harvard.edu/abs/{}/abstract'.format(paper.bibcode)

def rearrange_name(name):
    backwards_name_mather = re.compile('([^,]+),\s+([^,]+)')
    match_data = backwards_name_mather.match(name)
    
    def strip_str(s):
        return s.strip()

    if match_data is not None:
        return ' '.join(map(strip_str, reversed(name.split(','))))
    else:
        return name


def authors_html(names):
    def bold_me(author, me=['William', 'Wolf']):
        is_me = True
        for name in me:
            is_me = is_me & (name in author)
        if is_me:
            return "<strong>{}</strong>".format(author)
        else:
            return author

    revised_authors = map(rearrange_name, names)
    revised_authors = list(map(bold_me, revised_authors))

    if len(revised_authors) == 1:
        return revised_authors[0]
    elif len(revised_authors) == 2:
        return revised_authors.join(' and ')
    elif len(revised_authors) == 3:
        return ', '.join(revised_authors[0:2]) + ', and ' + revised_authors[-1]
    else:
        return ', '.join(revised_authors[0:3]) + ', et al.'


def make_html(paper, indent=''):
    res = []
    res.append(indent + '<a href="{}" '.format(make_url(paper)) +
              'class="list-group-item list-group-item-action" target=_blank>')
    res.append(indent + '  <div class="d-flex w-100 justify-content-between">')
    res.append(indent + '    <h5 class="mb-1">{}</h5>'.format(paper.title[0]))
    res.append(indent + '    <small>{}</small>'.format(paper.year))
    res.append(indent + '  </div>')
    res.append(indent + '  <p class="mb-1">{}</p>'.format(authors_html(paper.author)))
    res.append(indent + '  <small>{}</small>'.format(paper.pub))
    res.append(indent + '</a>')
    return '\n'.join(res)

def update_paper_html(filename, papers):
    with open(filename, 'w') as f:
        for paper in papers:
            f.write(make_html(paper))

def update_first_author_papers(papers):
    filename = join('..', '_includes', 'first_author_papers.html')
    update_paper_html(filename, papers)

def update_other_papers(papers):
    filename = join('..', '_includes', 'other_papers.html')
    update_paper_html(filename, papers)

def is_not_thesis(paper):
    return not (paper.pub == "Ph.D. Thesis")

def is_not_erratum(paper):
    return not ('Erratum' in paper.title[0])

def repeated_filter(filters, iterable):
    res = iterable
    for filt in filters:
        res = filter(filt, res)
    return res

ORC_ID = "0000-0002-6828-0630"
NAME = "Wolf, William M."
ATTS = ['bibcode', 'title', 'author', 'pub', 'year']

if __name__ == '__main__':
    all_papers = list(ads.SearchQuery(
        orcid=ORC_ID,
        sort="date+desc",
        property='refereed',
        fl=ATTS
    ))

    first_author_papers = list(ads.SearchQuery(
        first_author=NAME,
        orcid=ORC_ID,
        sort="date+desc",
        property='refereed',
        fl=ATTS
    ))

    # remove duplicates from all papers
    for paper in first_author_papers:
        all_papers.remove(paper)

    # throw out errata and thesis
    first_author_papers = repeated_filter(
        (is_not_thesis, is_not_erratum), first_author_papers
    )
    all_papers = repeated_filter(
        (is_not_thesis, is_not_erratum), all_papers
    )

    # output files
    update_first_author_papers(first_author_papers)
    update_other_papers(all_papers)

    

