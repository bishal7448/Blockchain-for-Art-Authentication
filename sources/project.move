module MyModule::ArtAuth {
    
    use aptos_framework::signer;

    /// Struct representing an artwork with a unique ID and owner.
    struct Artwork has store, key {
        owner: address,
    }

    /// Function to register a new artwork with a unique ID.
    public fun register_artwork(creator: &signer, art_id: u64) {
        let artwork = Artwork { owner: signer::address_of(creator) };
        move_to(&creator, artwork);
    }

    /// Function to transfer ownership of an artwork.
    public fun transfer_ownership(sender: &signer, art_id: u64, new_owner: address) acquires Artwork {
        let artwork = borrow_global_mut<Artwork>(signer::address_of(sender));
        assert!(artwork.owner == signer::address_of(sender), 1);
        artwork.owner = new_owner;
    }
}
