package MD5Check;

require  Exporter;
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);


our @ISA     = qw(Exporter);
our @EXPORT  = qw(md5init md5check);
our @version = 0.1;

sub md5_sum {

 my ($file_name,$mode)=@_;
 my ($FD,$ctx, $md5);
   open ($FD,$file_name) or die "Can't open /'$file_name/': $!";
     $ctx = Digest::MD5->new;
       binmode($FD) if $mode;
     $ctx->addfile($FD) || die "$!\n";
    $md5 = $ctx->hexdigest;
   close $FD;
 return $md5;
}

sub md5check {
my $file=shift;
open(my $fd, '<',$file) or die "$file: $!\n";
print $file;
while (<$fd>){
        my ($name, $sum) = split /\s+/;
        $name =~ s/^\*//;
        if ($sum eq md5_sum($name,1)){
                print "$name OK\n";
        }
        else{
          print "$name FAILED\n";
        }
}

close $fd;

}
# 遍历目录计算md5值
sub md5init {

    my $fd=shift;
    my $md5value;
    if ( -f $fd ){
            if ( -T $fd ) {
                #print "按照文本模式进行计算MD5!\n";
                $md5value =md5_sum($fd,0);
                print "$fd\t$md5value\n";
            }elsif( -B $fd ){
                #print "二进制文件用binmod计算MD5!\n";
                $md5value =md5_sum($fd,1);
                print "$fd\t$md5value\n";
            }else{
                #print "其他文件，按照bimmod计算!\n";
                $md5value = md5_sum($fd,1);
                print "$fd\t$md5value\n";
            }
     }
     elsif( -d $fd ){
        my $file_md5;
      # print "开始验证目录下所有文件:\n";
       opendir (my $DH,$fd) or die "Can't open dir $fd: $!";
         for(readdir $DH ){
         my $file=$fd.'/'.$_;
      # 上级目录..，本目录. 以及连接文件跳过
         next if ($file =~ m{/.$} || $file =~ m{/..$} || -l $file );
         md5init($file);
        }
       closedir $DH;
    }

}

1;
__END__


=head1 NAME

MD5Check - Use it for init Web files's md5 values of your site(or other dir), and check if it changed.


=head1 SYNOPSIS

    use MD5Check;

    my $mydir=shift;
    md5init($mydir);

    use MD5Check;
    my $mydir=shift;
    md5check($mydir);

    # oneliner
    $ perl -MMD5Check -e ' md5init("/web")' >file
    $ perl -MMD5Check -e 'md5check(file)'

=head1 DESCRIPTION

MD5Check - Use it for init Web files's md5 values of your site(or other dir), and check if it changed.

MD5Check is not standardized. This module is far from complete.


=head2 IMPLEMENTATION

    use MD5Check;
    my $mydir=shift;
    md5init($mydir);

    use MD5Check;
    my $mydir=shift;
    md5check($mydir);

=head1 Git repo

L<http://github.com/a3f/MD5Check>

=head1 AUTHOR

orange C<< <linzhe@ijz.me> >>, L<http://ijz.me>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 linzhe

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

