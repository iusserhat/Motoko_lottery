import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Random "mo:base/Random";

actor Lottery {
    var katilimcilar: [Principal] = [];
    var cekilisBasladi: Bool = false;
    var kazanan: ?Principal = null;

    public func katil(uye: Principal): async Bool {
        if (cekilisBasladi or Array.contains<Principal>(katilimcilar, uye)) {
            return false;
        } else {
            katilimcilar := Array.append<Principal>(katilimcilar, [uye]);
            return true;
        }
    };

    public func cekilisiBaslat(): async ?Principal {
        if (cekilisBasladi or katilimcilar.size() == 0) {
            return null;
        } else {
            cekilisBasladi := true;
            let rastgeleIndex = Nat.mod(Random.rand(), katilimcilar.size());
            kazanan := ?katilimcilar[rastgeleIndex];
            return kazanan;
        }
    };

    public query func kazananiGor(): async ?Principal {
        return kazanan;
    };
}

