requires 'XML::LibXML', '1.66';
requires 'XML::SAX';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.36';
    requires 'Test::More';
};
