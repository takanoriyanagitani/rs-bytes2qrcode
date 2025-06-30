use anyhow::Result;
use qrcode::QrCode;
use std::env;
use std::io::{self, Read};

fn main() -> Result<()> {
    let limit = match env::var("QR_MAX_BYTES") {
        Ok(s) => s.parse().unwrap_or(32),
        Err(_) => 32,
    };

    let mut buffer = Vec::new();
    io::stdin().take(limit).read_to_end(&mut buffer)?;

    let code = QrCode::new(&buffer)?;

    let qr_code_string = code
        .render::<char>()
        .quiet_zone(false)
        .module_dimensions(2, 1)
        .build();

    println!("{}", qr_code_string);

    Ok(())
}
