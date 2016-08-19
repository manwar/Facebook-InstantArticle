package Facebook::InstantArticle::Blockquote;
use Moose;
use namespace::autoclean;

extends 'Facebook::InstantArticle::BaseElement';

has 'text' => (
    isa => 'Str',
    is => 'rw',
    required => 1,
    default => 1,
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( text => $_[0] );
    }
    else {
        return $class->$orig( @_ );
    }
};

has 'is_valid' => (
    isa => 'Bool',
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;

        return length $self->text;
    },
);

has 'as_xml_gen' => (
    isa => 'Object',
    is => 'ro',
    lazy => 1,
    builder => '_build_as_xml_gen',
);

sub _build_as_xml_gen {
    my $self = shift;

    my $gen = XML::Generator->new( ':pretty' );

    return $gen->blockquote(
        \$self->text,
    );
}

1;
