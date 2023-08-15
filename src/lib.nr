use dep::fraction;
use dep::std;

global V_MAX: Phy_Vector = Phy_Vector { i: fraction::MAX, j: fraction::MAX, k: fraction::MAX  };
global V_MIN: Phy_Vector = Phy_Vector { i: fraction::MIN, j: fraction::MIN, k: fraction::MIN  };
global V_ZERO: Phy_Vector = Phy_Vector { i: fraction::ZERO, j: fraction::ZERO, k: fraction::ZERO };
global V_ONE: Phy_Vector = Phy_Vector { i: fraction::ONE, j: fraction::ONE, k: fraction::ONE };
global V_NEGATIVE_ONE: Phy_Vector = Phy_Vector { i: fraction::NEGATIVE_ONE, j: fraction::NEGATIVE_ONE, k: fraction::NEGATIVE_ONE };
global V_ONE_X: Phy_Vector = Phy_Vector { i: fraction::ONE, j: fraction::ZERO, k: fraction::ZERO };
global V_NEGATIVE_ONE_X: Phy_Vector = Phy_Vector { i: fraction::NEGATIVE_ONE, j: fraction::ZERO, k: fraction::ZERO };
global V_ONE_Y: Phy_Vector = Phy_Vector { i: fraction::ZERO, j: fraction::ONE, k: fraction::ZERO };
global V_NEGATIVE_ONE_Y: Phy_Vector = Phy_Vector { i: fraction::ZERO, j: fraction::NEGATIVE_ONE, k: fraction::ZERO };
global V_ONE_Z: Phy_Vector = Phy_Vector { i: fraction::ZERO, j: fraction::ZERO, k: fraction::ONE };
global V_NEGATIVE_ONE_Z: Phy_Vector = Phy_Vector { i: fraction::ZERO, j: fraction::ZERO, k: fraction::NEGATIVE_ONE };

struct Phy_Vector {
    i: fraction::Fraction,
    j: fraction::Fraction,
    k: fraction::Fraction,
}


// Create a Vector Variable simply
fn toVector(fi: fraction::Fraction, fj: fraction::Fraction, fk: fraction::Fraction) -> Phy_Vector {
    
    let vc = Phy_Vector {
        i: fi,
        j: fj,
        k: fk,
    };
    vc
}


// The x component of the Vector
fn xOfVector(v: Phy_Vector) -> fraction::Fraction {
    v.i
}

// The y component of the Vector
fn yOfVector(v: Phy_Vector) -> fraction::Fraction {
    v.j
}

// The z component of the Vector
fn zOfVector(v: Phy_Vector) -> fraction::Fraction {
    v.k
}


// Add two vectors
fn addVector(v1: Phy_Vector, v2: Phy_Vector) -> Phy_Vector {
    let vc = Phy_Vector {
        i: fraction::addFraction(v1.i, v2.i),
        j: fraction::addFraction(v1.j, v2.j),
        k: fraction::addFraction(v1.k, v2.k),
    };
    vc
}


// Subtract the second vector from the first
fn subtractVector(v1: Phy_Vector, v2: Phy_Vector) -> Phy_Vector {
    let vc = Phy_Vector {
        i: fraction::subtractFraction(v1.i, v2.i),
        j: fraction::subtractFraction(v1.j, v2.j),
        k: fraction::subtractFraction(v1.k, v2.k),
    };
    vc
}


// The scalar product of two vectors
fn scProductVector(v1: Phy_Vector, v2: Phy_Vector) -> fraction::Fraction {
    let s1 = fraction::multiplyFraction(v1.i, v2.i);
    let s2 = fraction::multiplyFraction(v1.j, v2.j);
    let s3 = fraction::multiplyFraction(v1.k, v2.k);
    let s4 = fraction::addFraction(s1, s2);
    let s = fraction::addFraction(s3, s4);
    s
}


// The vector product of two vectors
fn vecProductVector(v1: Phy_Vector, v2: Phy_Vector) -> Phy_Vector {
    //   i    j    k
    // v1.i v1.j v1.k
    // v2.i v2.j v2.k
    let m11 = fraction::multiplyFraction(v1.j, v2.k);
    let m12 = fraction::multiplyFraction(v1.k, v2.j);
    let m21 = fraction::multiplyFraction(v1.k, v2.i);
    let m22 = fraction::multiplyFraction(v1.i, v2.k);
    let m31 = fraction::multiplyFraction(v1.i, v2.j);
    let m32 = fraction::multiplyFraction(v1.j, v2.i);
    let d1 = fraction::subtractFraction(m11, m12);
    let d2 = fraction::subtractFraction(m21, m22);
    let d3 = fraction::subtractFraction(m31, m32);
    let v = Phy_Vector {
        i: d1,
        j: d2,
        k: d3,
    };
    v
}


// The square of the magnitude of a vector
fn sqModulusVector(v: Phy_Vector) -> fraction::Fraction {
    let s = scProductVector(v, v);
    s
}


// Returns true if two vectors are exactly equal
fn isEqual(v1: Phy_Vector, v2: Phy_Vector) -> bool {
    let flagi = fraction::compareFraction(v1.i, v2.i);
    let flagj = fraction::compareFraction(v1.j, v2.j);
    let flagk = fraction::compareFraction(v1.k, v2.k);
    let flag = ((flagi + flagj) + flagk);
    if (flag == 0){
        true
    }
    else {
        false
    }
    
}

// Returns true if the vector is a zero vector
fn isZero(v1: Phy_Vector) -> bool {
    let v2 = V_ZERO;
    let flagi = fraction::compareFraction(v1.i, v2.i);
    let flagj = fraction::compareFraction(v1.j, v2.j);
    let flagk = fraction::compareFraction(v1.k, v2.k);
    let flag = ((flagi + flagj) + flagk);
    if (flag == 0){
        true
    }
    else {
        false
    }
    
}


// Inverts the Vector Along the YZ Plane
fn invertX(v: Phy_Vector) -> Phy_Vector {
    let inv = fraction::Fraction {
        sign: (!v.i.sign),
        num: v.i.num,
        den: v.i.den,
    };
    let pv = Phy_Vector {
        i: inv,
        j: v.j,
        k: v.k,
    };
    pv
}

// Inverts the Vector Along the ZX Plane
fn invertY(v: Phy_Vector) -> Phy_Vector {
    let inv = fraction::Fraction {
        sign: (!v.j.sign),
        num: v.j.num,
        den: v.j.den,
    };
    let pv = Phy_Vector {
        i: v.i,
        j: inv,
        k: v.k,
    };
    pv
}


// Inverts the Vector Along the XY Plane
fn invertZ(v: Phy_Vector) -> Phy_Vector {
    let inv = fraction::Fraction {
        sign: (!v.k.sign),
        num: v.k.num,
        den: v.k.den,
    };
    let pv = Phy_Vector {
        i: v.i,
        j: v.j,
        k: inv,
    };
    pv
}


#[test]
fn test_create_vector() {
    let f1 = fraction::toFraction(true, 2, 5);
    let f2 = fraction::toFraction(true, 1, 5);
    let f3 = fraction::toFraction(true, 3, 5);
    let v = toVector(f1, f2, f3);
    assert (v.i.num == 2);
    
    
}


#[test]
fn test_sum_vector() {
    let f1 = fraction::toFraction(true, 2, 5);
    let f2 = fraction::toFraction(true, 1, 6);
    let f3 = fraction::toFraction(true, 3, 7);
    let v1 = toVector(f1, f2, f3);
    let f4 = fraction::toFraction(true, 1, 5);
    let f5 = fraction::toFraction(true, 4, 6);
    let f6 = fraction::toFraction(true, 3, 7);
    let v2 = toVector(f4, f5, f6);
    let vsum = addVector(v1, v2);
    
    assert (fraction::compareFraction(vsum.j, fraction::toFraction(true, 30, 36)) == 0);
    
    
}

#[test]
fn test_scalar_product_vector() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 1, 1);
    let f3 = fraction::toFraction(true, 1, 1);
    let v1 = toVector(f1, f2, f3);
    let f4 = fraction::toFraction(true, 1, 1);
    let f5 = fraction::toFraction(true, 1, 1);
    let f6 = fraction::toFraction(true, 1, 1);
    let v2 = toVector(f4, f5, f6);
    let vsp = scProductVector(v1, v2);
    assert (vsp.num == 3); 
    
    
    
}


#[test]
fn test_vector_product_vector() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 2, 1);
    let f3 = fraction::toFraction(true, 3, 1);
    let v1 = toVector(f1, f2, f3);
    
    let vvp = vecProductVector(v1, v1);
    assert (vvp.i.num == 0); 
    assert (vvp.j.num == 0); 
    assert (vvp.k.num == 0); 
    
    
    
}

#[test]
fn test_vector_unit_vectors() {
    let un1 = V_ONE_X;
    let un2 = V_ONE_Y;
    let un3 = V_ONE_Z;
    
    let s1 = addVector(un1, un2);
    let s = addVector(s1, un3);
    let sp = sqModulusVector(s);

    assert (sp.num == 3); 
    
      
}


#[test]
fn test_vector_negative_unit_vectors() {
    let un1 = V_NEGATIVE_ONE_X;
    let un2 = V_NEGATIVE_ONE_Y;
    let un3 = V_NEGATIVE_ONE_Z;
    
    let s1 = addVector(un1, un2);
    let s = addVector(s1, un3);
    
    let sp = sqModulusVector(s);
    

    assert (sp.num == 3); 
     
        
}


#[test]
fn test_equal_vector() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 2, 1);
    let f3 = fraction::toFraction(true, 3, 1);
    let v1 = toVector(f1, f2, f3);
    
    let eq = isEqual(v1, v1);
    assert (eq); 
     
}


#[test]
fn test_not_equal_vector() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 2, 1);
    let f3 = fraction::toFraction(true, 3, 1);
    let v1 = toVector(f1, f2, f3);
    let v2 = toVector(f3, f2, f1);
    let eq = isEqual(v1, v2);
    assert (!eq); 
     
}


#[test]
fn test_is_zero_vector() {
    let f1 = fraction::toFraction(true, 0, 1);
    let f2 = fraction::toFraction(true, 0, 1);
    let f3 = fraction::toFraction(true, 0, 1);
    let v = toVector(f1, f2, f3);
    
    let ze = isZero(v);
    assert (ze); 
     
}

#[test]
fn test_sq_modulus() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 1, 1);
    let f3 = fraction::toFraction(false, 1, 1);
    let v = toVector(f1, f2, f3);
    let sqmod = sqModulusVector(v);
    let sp = scProductVector(v, v);
    assert (sp.num == sqmod.num);
    assert (sp.den == sqmod.den);
}

#[test]
fn test_inversion_X() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 1, 1);
    let f3 = fraction::toFraction(false, 1, 1);
    let v = toVector(f1, f2, f3);
    let vix = invertX(v);
    assert (!vix.i.sign);
}


#[test]
fn test_inversion_Y() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 1, 1);
    let f3 = fraction::toFraction(false, 1, 1);
    let v = toVector(f1, f2, f3);
    let viy = invertY(v);
    assert (!viy.j.sign);
}

#[test]
fn test_inversion_Z() {
    let f1 = fraction::toFraction(true, 1, 1);
    let f2 = fraction::toFraction(true, 1, 1);
    let f3 = fraction::toFraction(false, 1, 1);
    let v = toVector(f1, f2, f3);
    let viz = invertZ(v);
    assert (viz.k.sign);
}