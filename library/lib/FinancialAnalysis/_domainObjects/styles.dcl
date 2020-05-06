// @alacambre Some styles that are maybe interesting → to filter.

Style DDMMYYSlash
    --> dateFormat  -> DateFormat
        --> month _DATE_MM
        --> day _DATE_DD
        --> year _DATE_YYYY
        --> ddMMSeparator "/"
        --> timeZoneSuffix _NO_SUFFIX
    ;
;

Style dateYYYYNoTimeZone
    --> dateFormat  -> DateFormat
        --> year _DATE_YYYY
        --> timeZoneSuffix _NO_SUFFIX
    ;
;

Style oneDecimal
    --> decimalsCount 1
;

Style separateThousands
    --> separateThousands true
    --> thousandSeparator " "
;

Unit UNIT_BPS
    --> decimalsCount 0
    --> symbol "bps"
;
