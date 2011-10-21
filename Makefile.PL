use strict;
use inc::Module::Install;

eval {
    require XML::SAX;

    my $mod = 'XML::LibXML::SAX::ChunkParser';
    if( grep {$_->{'Name'} eq $mod} @{XML::SAX->parsers()} ) {
        my $y = prompt(<<EOM, "y");

$mod found in your ParserDetails.ini.
Since $mod is not really a full-fledged parser, 
you probably should remove this to avoid accidentaly breakage. 

Remove $mod?
(If in doubt, answer 'y') 
EOM
        if ($y) {
            XML::SAX->remove_parser($mod)->save_parsers()
        }
    }
};
if ($@) {
    print STDERR <<EOM;

!!! WARNING !!! WARNING !!! WARNING !!!
Problems encountered while removing XML::LibXML::SAX::ChunkParser from your
ParserDetails.ini:

  $@

If this is a permission problem, you should run this script as root
(or whatever necessary), or remove the entry by hand.

EOM
}

name('XML-LibXML-SAX-ChunkParser');
all_from('lib/XML/LibXML/SAX/ChunkParser.pm');

requires 'XML::LibXML', 1.66;
requires 'XML::SAX';

test_requires 'Test::More';

auto_include;
WriteAll;

#sub MY::install {
#    package MY;
#    my $script = shift->SUPER::install(@_);
#    if (ExtUtils::MakeMaker::prompt(
#        "Do you want to modify ParserDetails.ini?", 'Y')
#        =~ /^y/i) {
#        $script =~ s/install :: (.*)$/install :: $1 install_sax_driver/m;
#        $script .= <<"INSTALL";
#  
#install_sax_driver :
#\t\@\$(PERL) -MXML::SAX -e "XML::SAX->add_parser(q(\$(NAME)))->save_parsers()"
#  
#INSTALL
#    }
#    return $script;
#}